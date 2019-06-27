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
    
    //lazy var application = UIApplication.shared
    
    var target: NotificationTarget?
    var expirationDate: Date?
    var link: String?
    
    convenience init(_  userInfo: [AnyHashable: Any] ) {
    
        self.init()
    //func processNotificationWithInfo(_ userInfo: [AnyHashable: Any] ) {
        
//        for key in userInfo.keys {
//                    print("\n\n\(key)\n")
//                    print(userInfo[key])
//        }
        
        if let targetName = userInfo["target"] as? String,
           let target = NotificationTarget.allCases.filter({ (n) -> Bool in
                n.decsription() == targetName
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
            }
        }
    }
    
    func saveNotificationStatus() {
        UIApplication.shared.applicationIconBadgeNumber += 1
        guard let target = target else { return }
        Settings.saveNotificationStatusForTarget(target, date: expirationDate)
        
    }
    
    func openTargetViewController(in window: UIWindow?) {
        
        guard let target = self.target else { return }
        let tabBarController = KSOTabViewController.instantiate()
        
        switch target {
        case .policyChange:
            guard link != nil else {
                break
            }
            ///.webUrlString = link!
        case .actionAlert:
            tabBarController.switchToActionAlertScreen()
        case .newsAndMedia:
            tabBarController.switchToNewsAndMediaScreen()
        case .newHighScore:
            tabBarController.switchToHighScoreScreen()
        case .signatureCampaign: break
        }
        
        window?.rootViewController = tabBarController
    }
    
}
