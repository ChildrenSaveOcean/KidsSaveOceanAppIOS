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
            CountriesService.shared().setup()
        }
        
        // MARK: - Check if user already opened the tutorial screen
        if UserDefaultsHelper.isOnBoardingHasBeenShown() {
            window?.rootViewController = KSOTabViewController.instantiate()
        } else {
            window?.rootViewController = KSOStartPageViewController.instantiate()
        }
        
        // MARK: all about notifications here and below:
        Messaging.messaging().delegate = self
        NotificationController.shared().requestAuthorization()

        // MARK: - Get application instance ID
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instance ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
            }
        }
        
        application.registerForRemoteNotifications()
        
        // MARK: - Get notification if application was terminated
        let notificationInfo = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? [AnyHashable: Any]
        NotificationController.shared().processNotification(with: notificationInfo)

        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        NotificationController.shared().processDeliveredNotifications()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    //
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        UserViewModel.shared().saveUser()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        NotificationController.shared().processNotification(with: userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        let dataDict = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        
        messaging.subscribe(toTopic: "all")
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }
}
