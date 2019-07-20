//
//  Settings.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 7/17/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import Foundation

class Settings: NSObject {

    static let tabViewControllerId = "tabViewController"
    static let onBoardingViewControllerId = "onBoardingViewController"
    static let countryContactController = "CountryContactsViewController"
    static let onBoardingKey = "onBoarding"

    static let onBoardingStoryboardName = "Onboarding"

    static let completionStatusKey = "completionStatusKey"
    static let notificationsKey = "notificationsKey"

    static let CountriesHasBeenLoadedNotificationName = "CountriesHasBeenLoaded"
    static let UserHasBeenLoadedNotificationName  = "UserHasBeenLoaded"
    
    static let unreadNotificationNumberKey = "UnreadNotificationNumber"
    
    static let actionAlertStateKey = "UnreadNotificationNumber"
    
    static let dateFormatter: DateFormatter = {
        let datef = DateFormatter()
        datef.dateFormat = "dd.MM.yyyy"
        return datef
    }()
    
    class func saveOnBoardingHasBeenShown() {
        UserDefaults.standard.set(true, forKey: onBoardingKey)
        UserDefaults.standard.synchronize()
    }

    class func isOnBoardingHasBeenShown() -> Bool {
        return UserDefaults.standard.bool(forKey: onBoardingKey)
    }

    class func saveCompletionTasksStatus(_ states: [Bool]) {
        UserDefaults.standard.set(states, forKey: completionStatusKey)
        UserDefaults.standard.synchronize()
    }

    class func getCompletionTasksStatus() -> [Bool] {
        guard let states = UserDefaults.standard.array(forKey: completionStatusKey) as? [Bool] else {
            return Array.init(repeating: false, count: 6)
        }
        return states
    }
    
    class func saveNotifications(_ notifications: [NotificationItem]) {
            UserDefaults.standard.set(notifications, forKey: notificationsKey)
            UserDefaults.standard.synchronize()
    }
    
    class func getNotifications() -> [NotificationItem] {
        return UserDefaults.standard.array(forKey: notificationsKey) as? [NotificationItem] ?? [NotificationItem]()
    }
    
//    class func getNotificationStatusForTarget(_ target: NotificationTarget) -> Date? {
//        guard let expirationDate = UserDefaults.standard.string(forKey: target.decsription()) else {return nil}
//        return dateFormatter.date(from: expirationDate)
//    }
//
//    class func saveNotificationStatusForTarget(_ target: NotificationTarget, date: Date) {
//        let expirationDate = dateFormatter.string(from: date)
//        UserDefaults.standard.set(expirationDate, forKey: target.decsription())
//        UserDefaults.standard.synchronize()
//    }
//
//    class func clearNotificationStatusForTarget(_ target: NotificationTarget) {
//        UserDefaults.standard.removeObject(forKey: target.decsription())
//        UserDefaults.standard.synchronize()
//    }
}
