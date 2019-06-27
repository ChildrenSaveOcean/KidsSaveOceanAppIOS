//
//  AppDelegate.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 5/17/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var notificationController = NotificationController() // TODO ??

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()

        LocationService.shared().autorizeLocation(completionHandler: nil)
        
        KSOAuthorization.anonymousAuthorization {
            UserViewModel.shared()
        }
        //# MARK: - Check if user already opened the tutorial screen
        if Settings.isOnBoardingHasBeenShown() {
            window?.rootViewController = KSOTabViewController.instantiate()
        } else {
            window?.rootViewController = KSOStartPageViewController.instantiate()
        }

        CountriesService.shared().setup()
        
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]

        //Solicit permission from the user to receive notifications
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { (_, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
        }
        
        //get application instance ID
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instance ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
            }
        }
        
        application.registerForRemoteNotifications()
        
        UIApplication.shared.applicationIconBadgeNumber = NotificationController.getNotificationCount()
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        NotificationCenter.default.post(name: Notification.Name.NSExtensionHostDidBecomeActive, object: nil, userInfo: nil)
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        notificationController.openTargetViewController(in: window)
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        notificationController.processNotification(with: userInfo)
        notificationController.saveNotificationStatus()
        if application.applicationState == .active {
            notificationController.refreshReferencedView(in: window)
        }
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
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
        
        messaging.subscribe(toTopic: "all")
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }
}
