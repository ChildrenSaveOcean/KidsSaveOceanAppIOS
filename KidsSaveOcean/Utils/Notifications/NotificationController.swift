//
//  NotificationController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 6/24/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

//import Foundation
import UIKit

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

class NotificationController {
    let gcmMessageIDKey = "gcm.message_id"
    let googleNotificationNameIDKey = "google.c.a.c_l"
    let timeToLiveIDKey = "gcm.notification.time_to_live"
    
    var target: NotificationTarget = .unknown
    var expirationDate: Date?
    var link: String?
    
    func processNotification(with userInfo: [AnyHashable: Any] ) {
        self.target = .unknown
        if let targetName = userInfo["target"] as? String,
           let target = NotificationTarget.allCases.filter({ (notificationTarget) -> Bool in
                notificationTarget.decsription() == targetName
            }).first {
        
            self.target = target
            
            if let liveSecondsString = userInfo[timeToLiveIDKey] as? String,
                let liveSecondsInt = Int(liveSecondsString),
                liveSecondsInt > 0 {
                expirationDate = Date().addingTimeInterval(TimeInterval(liveSecondsInt))
            } else {
                expirationDate = Date().addingTimeInterval(TimeInterval(Int32.max))
            }
            
            if let linkFromNotification = userInfo["link"] as? String,
                !linkFromNotification.isEmpty {
                self.link = linkFromNotification
            } else {
                self.link = ""
            }
        }
        
        saveNotificationStatus()
    }
    
    func saveNotificationStatus() {
        Settings.saveNotificationStatusForTarget(target, date: expirationDate)
    }
    
    func openTargetViewController(in window: UIWindow?) {
    
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
            break
        default:
            break
        }
        
        window?.rootViewController = tabBarController
    }
    
    func refreshReferencedView(in window: UIWindow?) {
        guard let tabBarController = window?.rootViewController as? KSOTabViewController else {return}
        tabBarController.updateNotificationStatusOfSelectedViewController()
    }
    
    static func getNotificationCount() -> Int {
        return NotificationTarget.allCases.filter({Settings.getNotificationStatusForTarget($0) != nil}).count
    }
}
