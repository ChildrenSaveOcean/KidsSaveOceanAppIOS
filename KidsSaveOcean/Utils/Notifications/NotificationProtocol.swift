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
    
    func isNotificationActualForTarget(_ target: NotificationTarget) -> Bool?
    func checkNotificationStatusForTarget(_ target: NotificationTarget)
    func clearNotificationForTarget(_ target: NotificationTarget)
    func updateViews()
    func clearNotifications() 
}

extension NotificationProtocol {
    var notificationTargets: [NotificationTarget] {
        return []
    }
    
    func isNotificationActualForTarget(_ target: NotificationTarget) -> Bool? {
        guard let expDate = Settings.getNotificationStatusForTarget(target) else {return nil}
        let notificationIsNotExpired = Date().compare(expDate) == ComparisonResult.orderedAscending
        return notificationIsNotExpired
    }
    
    func checkNotificationStatusForTarget(_ target: NotificationTarget) {
        guard let notificationIsActual = isNotificationActualForTarget(target) else {return}
        if !notificationIsActual {
            clearNotificationForTarget(target)
        }
    }
    
    func clearNotificationForTarget(_ target: NotificationTarget) {
        Settings.saveNotificationStatusForTarget(target, date: nil)
        UIApplication.shared.applicationIconBadgeNumber = NotificationController.getNotificationCount()
    }
    
    func updateViews() {
        //
    }
    
    func clearNotifications() {
        for target in notificationTargets {
            clearNotificationForTarget(target)
        }
    }
}
