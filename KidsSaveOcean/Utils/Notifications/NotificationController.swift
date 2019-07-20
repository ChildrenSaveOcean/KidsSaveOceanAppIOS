//
//  NotificationController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 6/24/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

//import Foundation
import UIKit
import UserNotifications

class NotificationController: NSObject {
    
    let gcmMessageIDKey = "gcm.message_id"
    let googleNotificationNameIDKey = "google.c.a.c_l"
    let timeToLiveIDKey = "gcm.notification.time_to_live"
    let messageIDKey = "gcm.message_id"
    
    private static var sharedNotificationController: NotificationController = {
        let notificationController = NotificationController()
        UNUserNotificationCenter.current().delegate = notificationController
        return notificationController
    }()
    
    class func shared() -> NotificationController {
        return sharedNotificationController
    }
    
    var notifications = Settings.getNotifications()
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (_, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
        }
    }
    
    func processNotification(with userInfo: [AnyHashable: Any]?) -> NotificationItem? {
        
        guard let userInfo = userInfo, userInfo.keys.count > 0 else {
            processDeliveredNotifications()
            return nil
        }
        
        // check if the notification has been already processed
        guard let messageId = userInfo[messageIDKey] as? String,
                notifications.filter({$0.id == messageId}).count == 0 else {
                return nil
        }
        
        let target = getTargetFromString(userInfo["target"] as? String)
        if notifications.filter({$0.target == target}).count > 0 {
            clearNotificationsWithTargets([target])
        }
        
        print("process notification \(target) with id \(messageId) from UNUserNotificationCenter\n")
        
        let link = userInfo["link"] as? String ?? ""
        let expirationDate = getExpirationDate(from: userInfo[timeToLiveIDKey] as? String)
        
        let notification = NotificationItem(id: messageId, target: target, link: link, expirationDate: expirationDate)
        notifications.append(notification)
        
        UIApplication.shared.applicationIconBadgeNumber = notifications.count
        
        Settings.saveNotifications(notifications)
        removeDeliveredNotification(notification)
        refreshReferencedView()
        return notification
    }
    
    func refreshReferencedView() {
        guard let window = UIApplication.shared.delegate?.window as? UIWindow,
            let tabBarController = window.rootViewController as? KSOTabViewController else {return}
        tabBarController.updateNotificationStatusOfSelectedViewController()
    }
    
    func processDeliveredNotifications() {
        UNUserNotificationCenter.current().getDeliveredNotifications { deliveredNotifications in
            for notification in deliveredNotifications {
                DispatchQueue.main.sync {
                    self.processNotification(with: notification.request.content.userInfo)
                }
            }
            DispatchQueue.main.sync {
                UIApplication.shared.applicationIconBadgeNumber = self.notifications.count
            }
        }
    }
    
    func openTargetViewController(for notificationItem: NotificationItem) {
    
        let tabBarController = KSOTabViewController.instantiate()
        
        switch notificationItem.target {
        case .policyChange:
            guard let link = notificationItem.link else { break }
            tabBarController.showLink(link, clear: notificationItem.target)
        case .actionAlert:
            tabBarController.switchToActionAlertScreen()
        case .newsAndMedia:
            tabBarController.switchToNewsAndMediaScreen()
        case .newHighScore:
            tabBarController.switchToHighScoreScreen()
        case .signatureCampaign:
            break // placeholder for the future actions
        default:
            break
        }
        
        if let window = UIApplication.shared.delegate?.window as? UIWindow {
            window.rootViewController = tabBarController
        }
    }
    
    func clearNotificationsWithTargets(_ targets: [NotificationTarget]) {
        notifications.removeAll(where: {targets.contains($0.target)})
        Settings.saveNotifications(notifications)
    }
    
    func getNotificationStatusForTarget(_ target: NotificationTarget) -> Bool {
        guard let expirationDate = notifications.filter({$0.target == target}).first?.expirationDate else {
            return true
        }
        return Date().compare(expirationDate) == ComparisonResult.orderedAscending
    }
    
        // MARK: Private methods
    private func removeDeliveredNotification(_ notification: NotificationItem) {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [notification.id])
    }
    
    private func clearNotifications(_ notification: NotificationItem) {
        if let index = notifications.index(of: notification) {
            notifications.remove(at: index)
        }
    }
    
    private func getTargetFromString(_ string: String?) -> NotificationTarget {
        return NotificationTarget.allCases.filter({ (notificationTarget) -> Bool in
            notificationTarget.decsription() == string
        }).first ?? .unknown
    }
    
    private func getExpirationDate(from seconds: String?) -> Date {
        let expDate: Date
        if seconds != nil,
            !seconds!.isEmpty,
            let liveSecondsInt = Int(seconds!),
            liveSecondsInt > 0 {
            expDate = Date().addingTimeInterval(TimeInterval(liveSecondsInt))
        } else {
            expDate = Date().addingTimeInterval(TimeInterval(Int32.max))
        }
        return expDate
    }
}

extension NotificationController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        guard let notificationId = userInfo[messageIDKey] as? String else {return}
        guard let notificationItem = notifications.filter({$0.id == notificationId}).first ?? processNotification(with: userInfo) else {return}
        openTargetViewController(for: notificationItem)
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
}
