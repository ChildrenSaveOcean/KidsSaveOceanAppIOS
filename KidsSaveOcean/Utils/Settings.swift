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

    static let CountriesHasBeenLoadedNotificationName = "CountriesHasBeenLoaded"
    static let UserHasBeenLoadedNotificationName  = "UserHasBeenLoaded"

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

}
