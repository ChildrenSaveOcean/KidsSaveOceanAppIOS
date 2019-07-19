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

enum NotificationTarget: String, CaseIterable {
    case
    unknown = " ",
    actionAlert = "ActionAlert",
    policyChange = "PolicyChange",
    newsAndMedia = "NewsAndMedia",
    newHighScore = "NewHighScore",
    signatureCampaign = "SignatureCampaign"
    
    func decsription() -> String {
        return self.rawValue
    }
}

class NotificationController: NSObject {
    
    private static var sharedNotificationController: NotificationController = {
        let notificationController = NotificationController()
        UNUserNotificationCenter.current().delegate = notificationController
        return notificationController
    }()
    
    class func shared() -> NotificationController {
        return sharedNotificationController
    }
    
    let gcmMessageIDKey = "gcm.message_id"
    let googleNotificationNameIDKey = "google.c.a.c_l"
    let timeToLiveIDKey = "gcm.notification.time_to_live"
    let messageIDKey = "gcm.message_id"
    
    var target: NotificationTarget = .unknown
    var expirationDate: Date?
    var link: String?
    var messageId: String?
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (_, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
        }
    }
    
    func processNotification(with userInfo: [AnyHashable: Any], completionHandler: (() -> Void)? ) {
        
        // check if the notification has been already processed
        guard let messageId = userInfo[messageIDKey] as? String,
        messageId != self.messageId else {return}
        
        let target = getTargetFromString(userInfo["target"] as? String)
        
        let link = userInfo["link"] as? String ?? ""
        let expirationDate = getExpirationDate(from: userInfo[timeToLiveIDKey] as? String)
        
        self.messageId = messageId
        self.target = target
        self.link = link
        self.expirationDate = expirationDate

        Settings.saveNotificationStatusForTarget(target, date: expirationDate)
        //UIApplication.shared.applicationIconBadgeNumber = NotificationController.getNotificationCount()
        
        completionHandler?()
    }
    
    func refreshReferencedView() {
        guard let window = UIApplication.shared.delegate?.window as? UIWindow,
            let tabBarController = window.rootViewController as? KSOTabViewController else {return}
        tabBarController.updateNotificationStatusOfSelectedViewController()
    }
    
    func processDeliveredNotifications() {
        UNUserNotificationCenter.current().getDeliveredNotifications { notifications in
            for notification in notifications {
                self.processNotification(with: notification.request.content.userInfo, completionHandler: nil)
            }
            DispatchQueue.main.async {
                self.refreshReferencedView()
                UIApplication.shared.applicationIconBadgeNumber = NotificationController.getNotificationCount()
            }
        }
    }
    
    func openTargetViewController() {
    
        let tabBarController = KSOTabViewController.instantiate()
        
        switch target {
        case .policyChange:
            guard let link = link else { break }
            tabBarController.showLink(link, clear: target)
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
    
    // MARK: Private methods
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
    
    // MARK: Static methods
    static func getNotificationCount() -> Int {
        return NotificationTarget.allCases.filter({Settings.getNotificationStatusForTarget($0) != nil}).count
    }
}

extension NotificationController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        self.openTargetViewController()
        
        completionHandler()
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
}
