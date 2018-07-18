//
//  Settings.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 7/17/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import Foundation

class Settings:NSObject {
    
    static let tabViewControllerId = "tabViewController"
    static let onBoardingViewControllerId = "onBoardingViewController"
    static let onBoardingKey = "onBoarding"
    
    class func saveOnBoardingHasBeenShown() {
        UserDefaults.standard.set(true, forKey: onBoardingKey)
        UserDefaults.standard.synchronize()
    }
    
    class func isOnBoardingHasBeenShown() -> Bool {
        return UserDefaults.standard.bool(forKey: onBoardingKey)
    }
}
