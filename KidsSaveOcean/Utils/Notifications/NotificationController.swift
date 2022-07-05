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
    
    var notifications = UserDefaultsHelper.getNotifications()
    
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
        guard let messageId = userInfo[messageIDKey] as? String else { return nil }
        guard notifications.filter({$0.id == messageId}).count == 0 else {
                removeDeliveredNotification(with: messageId)
                return nil
        }
        
        let target = NotificationTarget.getTargetFromString(userInfo["target"] as? String)
        if notifications.filter({$0.target == target}).count > 0 {
            clearNotificationsWithTargets([target])
        }
        
        let link = userInfo["link"] as? String ?? ""
        
        let secondString = userInfo[timeToLiveIDKey] as? String
        let expirationDate = getExpirationDate(from: secondString)
        if expirationDate != nil, secondString != nil, let seconds = Double(secondString!) {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
                self.refreshReferencedView()
                UIApplication.shared.applicationIconBadgeNumber = self.notifications.count
            }
        }
        
        let notification = NotificationItem(id: messageId, target: target, link: link, expirationDate: expirationDate)
        notifications.append(notification)
        
        UIApplication.shared.applicationIconBadgeNumber = notifications.count
        
        UserDefaultsHelper.saveNotifications([notification])
        removeDeliveredNotification(with: messageId)
        refreshReferencedView()
        return notification
    }
    
    func refreshReferencedView() {

        guard let window = UIApplication.shared.delegate?.window as? UIWindow,
            let tabBarController = window.rootViewController as? KSOTabViewController else { return }

        tabBarController.updateNotificationStatusOfSelectedViewController()
    }
    
    func processDeliveredNotifications() {

        UNUserNotificationCenter.current().getDeliveredNotifications { deliveredNotifications in

            DispatchQueue.main.async {

                for notification in deliveredNotifications {
    
                    self.processNotification(with: notification.request.content.userInfo)
                }
            }
        }
    }
    
    func openTargetViewController(for notificationItem: NotificationItem) {
    
        guard let tabBarController = UIApplication.shared.keyWindow?.rootViewController as? KSOTabViewController
            else { return }
        //KSOTabViewController.instantiate()
        
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
        UserDefaultsHelper.saveNotifications(notifications)
        UIApplication.shared.applicationIconBadgeNumber = self.notifications.count
    }
    
    func getNotificationStatusForTarget(_ target: NotificationTarget) -> Bool {

        guard let notification = notifications.filter({$0.target == target}).first else { return false }
        guard let expirationDate = notification.expirationDate else { return true }
        return Date().compare(expirationDate) == ComparisonResult.orderedAscending
    }
    
    // MARK: Private methods
    private func clearNotifications(_ notification: NotificationItem) {

        if let index = notifications.firstIndex(of: notification) {
            notifications.remove(at: index)
        }
    }
    
    private func removeDeliveredNotification(with messageId: String) {

        UNUserNotificationCenter.current().getDeliveredNotifications { deliveredNotifications in
            guard let currentNotification = deliveredNotifications.filter({
                guard let stringId = $0.request.content.userInfo[self.messageIDKey] as? String else { return false }
                return stringId == messageId
            }).first else { return }
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [currentNotification.request.identifier])
        }
    }
    
    private func getExpirationDate(from seconds: String?) -> Date? {

        let expDate: Date?
        if seconds != nil,
            !seconds!.isEmpty,
            let liveSecondsInt = Int(seconds!),
            liveSecondsInt > 0 {
            expDate = Date().addingTimeInterval(TimeInterval(liveSecondsInt))
        } else {
            expDate = nil //Date().addingTimeInterval(TimeInterval(Int32.max))
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
