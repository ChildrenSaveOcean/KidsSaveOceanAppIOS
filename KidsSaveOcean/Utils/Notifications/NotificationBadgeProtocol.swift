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

    private var redBadgeView: UIView? { return subviews.filter({$0.restorationIdentifier == notificationBadgeId}).first }

    func checkNotificationStatusForTarget(_ target: NotificationTarget) {
        
        let notificationIsActual = NotificationController.shared.getNotificationStatusForTarget(target) // ?? false

        if notificationIsActual && redBadgeView == nil {
            self.addRedBadge(with: 1)
        } else if !notificationIsActual && redBadgeView != nil {
            clearRedBadge()
            clearNotificationForTarget(target)
        }
    }

    func clearRedBadge() {
        redBadgeView?.removeFromSuperview()
    }
}
