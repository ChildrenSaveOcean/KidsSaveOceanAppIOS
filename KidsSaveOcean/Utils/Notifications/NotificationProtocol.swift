//
//  NotificationProtocol.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 6/26/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

protocol NotificationProtocol {
    
    var notificationTargets: [NotificationTarget] { get }
    
    func isNotificationActualForTarget(_ target: NotificationTarget) -> Bool
    func checkNotificationStatusForTarget(_ target: NotificationTarget)
    func clearNotificationForTarget(_ target: NotificationTarget)
    func updateViews()
    func clearNotifications() 
}

extension NotificationProtocol {
    var notificationTargets: [NotificationTarget] {
        return []
    }
    
    func isNotificationActualForTarget (_ target: NotificationTarget) -> Bool {
        return NotificationController.shared().getNotificationStatusForTarget(target)
    }
    
    func checkNotificationStatusForTarget(_ target: NotificationTarget) {
        if !isNotificationActualForTarget(target) {
            clearNotificationForTarget(target)
        }
    }
    
    func updateViews() {
        //
    }
    
    func clearNotificationForTarget(_ target: NotificationTarget) {
        NotificationController.shared().clearNotificationsWithTargets([target])
    }
    
    func clearNotifications() {
        NotificationController.shared().clearNotificationsWithTargets(notificationTargets)
    }
}
