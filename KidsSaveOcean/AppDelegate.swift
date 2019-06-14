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
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"

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
        //application.applicationIconBadgeNumber = 0//Settings.getUnreadNotificationNumber() // TODO
        
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(userInfo.keys)
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // TODO
        // this block will update app icon's badge from server side
//        if let messageBody = userInfo["aps"] as? NSDictionary {
//            guard let notificationCount = messageBody["badge"] as? Int else {return}
//            let badgeNum = notificationCount// + Settings.getUnreadNotificationNumber()
//            application.applicationIconBadgeNumber = badgeNum
//            //Settings.saveUnreadNotificationNumber(badgeNum)
//        }
        
        // the aps-parameter shoud send the "content-available = 1" for updating app icon's badge in the background mode.
        let state = application.applicationState
        switch state {
            
        case .inactive:
            print("Inactive")
            
        case .background:
            print("Background")
            // update badge count here
            application.applicationIconBadgeNumber += 1
            // TODO somewehere in the app it should be reset. 
            
        case .active:
            print("Active")
            
        }
        
        // Print full message.
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        let dataDict = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }
}
