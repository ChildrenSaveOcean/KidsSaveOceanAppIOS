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
    static let gcmMessageIDKey = "gcm.message_id"
    static let googleNotificationNameIDKey = "google.c.a.c_l"
    let timeToLiveIDKey = "gcm.notification.time_to_live"
    
    lazy var application = UIApplication.shared
    func processNotificationWithInfo(_ userInfo: [AnyHashable: Any] ) {
        
//        for key in userInfo.keys {
//                    print("\n\n\(key)\n")
//                    print(userInfo[key])
//        }
        
        if let targetName = userInfo["target"] as? String,
           let target = NotificationTarget.allCases.filter({ (n) -> Bool in
                n.decsription() == targetName
            }).first {
        
            var expirationDate: Date
            if let liveSecondsString = userInfo[timeToLiveIDKey] as? String,
                let liveSecondsInt = Int(liveSecondsString),
                liveSecondsInt > 0 {
                expirationDate = Date().addingTimeInterval(TimeInterval(liveSecondsInt))
            } else {
                expirationDate = Date().addingTimeInterval(TimeInterval(Int32.max))
            }
            
            let link: String?
            if let linkFromNotification = userInfo["link"] as? String,
                !linkFromNotification.isEmpty {
                link = linkFromNotification
            }
            
            if application.applicationState != .active {
                Settings.saveNotificationStatusForTarget(target, date: expirationDate)
                application.applicationIconBadgeNumber += 1
                return
            }
            
            switch target {
            case .policyChange: break
                // open Policy screen with link from userInfo
                // add badge to where?
            case .actionAlert: break
                // compare time
                //let alertActionVC = AlertActionDashboardViewController()
                //navigationController?.pushViewController(alertActionVC, animated: true)
            //actionAlertView.alpha = 0
            case .newsAndMedia: break
                // go to news And Media VC
                // red badge with num 1
            case .newHighScore: break
                // red badge on HighScoreCard
                // go to main screen
            case .signatureCampaign: break
                // link... to version 2 to do
            default: break
           }
            
        }
    }
    
}
