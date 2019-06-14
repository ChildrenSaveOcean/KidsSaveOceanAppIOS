//
//  AppDelegate.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 5/17/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()

        LocationService.shared().autorizeLocation(completionHandler: nil)
        
        KSOAuthorization.anonymousAuthorization {
            UserViewModel.shared()
        }
        //# MARK: - Check if user already opened the tutorial screen
        if Settings.isOnBoardingHasBeenShown() {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let tabViewController = storyBoard.instantiateViewController(withIdentifier: Settings.tabViewControllerId)
            window?.rootViewController = tabViewController
        } else {
            let storyBoard: UIStoryboard = UIStoryboard(name: Settings.onBoardingStoryboardName, bundle: nil)
            let onboardingViewController = storyBoard.instantiateViewController(withIdentifier: Settings.onBoardingViewControllerId)
            window?.rootViewController = onboardingViewController
        }

        CountriesService.shared().setup()
        return true
    }
}
