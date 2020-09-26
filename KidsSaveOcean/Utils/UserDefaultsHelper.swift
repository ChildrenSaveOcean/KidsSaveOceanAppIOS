//
//  UserDefaultsHelper.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 7/20/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import Foundation

class UserDefaultsHelper {
    
    static let unreadNotificationNumberKey = "UnreadNotificationNumber"
    static let onBoardingKey = "onBoarding"
    static let actionAlertStateKey = "UnreadNotificationNumber"
    static let notificationsKey = "notificationsKey"
    static let completionStatusKey = "completionStatusKey"
    static let countryLetterNumberKey = "countryLetterNumber"
    static let letterNumberKey = "letterNumber"
    
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
        let codedNotifications = try? NSKeyedArchiver.archivedData(withRootObject: notifications)
        UserDefaults.standard.set(codedNotifications, forKey: notificationsKey)
        UserDefaults.standard.synchronize()
    }
    
    class func getNotifications() -> [NotificationItem] {
        guard let codedNotification = UserDefaults.standard.value(forKey: notificationsKey) as? NSData,
            let notificationData = codedNotification as? Data,
            let notifications = NSKeyedUnarchiver.unarchiveObject(with: notificationData) as? [NotificationItem]
        else {
            return [NotificationItem]()
        }
        return notifications
    }
    
    class func countryLetterNumber() -> Int {
        return UserDefaults.standard.integer(forKey: countryLetterNumberKey) as Int
    }
    
    class func saveCountryLetterNumber(_ value: Int) {
        UserDefaults.standard.set(value, forKey: countryLetterNumberKey)
    }
    
    class func letterNumber() -> Int {
        return UserDefaults.standard.integer(forKey: letterNumberKey) as Int
    }
    
    class func saveLetterNumber(_ value: Int) {
         UserDefaults.standard.set(value, forKey: letterNumberKey)
    }
}
