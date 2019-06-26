//
//  NotificationBadgeProtocol.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 6/26/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

protocol NotificationBadgeProtocol: NotificationProtocol {
}

let notificationBadgeId = "NotificationBadgeIdentifier"
extension NotificationBadgeProtocol where Self: UIView {
    
    func checkNotificationStatusForTarget(_ target: NotificationTarget) {
        
        guard let notificationIsActual = isNotificationActualForTarget(target) else {return}
        let redBadgeView = getRedBadge()
        
        if notificationIsActual && redBadgeView == nil {
            self.addRedBadge(with: 1)
        } else if !notificationIsActual && redBadgeView != nil {
            redBadgeView?.removeFromSuperview()
            clearNotificationForTarget(target)
        }
    }
    
    private func getRedBadge() -> UIView? {
        return subviews.filter({$0.restorationIdentifier == notificationBadgeId}).first
    }
}
