//
//  AppDelegate.swift
//  Modernland Approval
//
//  Created by Kevin Correzian on 28/02/21.
//  Copyright © 2021 Modernland. All rights reserved.
//

import UIKit
import netfox
import UserNotifications
import Firebase
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    var deviceTokenString=""
    weak var viewController: LoginViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        // Override point for customization after application launch.
        //Messaging.messaging().delegate = self
        NFX.sharedInstance().start()
        self.settingPushNotification()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        
        let vc = StoryboardScene.Login.loginViewController.instantiate()
        window?.rootViewController = vc
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //print(deviceToken)
        //let deviceTokenString: String = ( deviceToken.description as String )
        //print(deviceTokenString)
        //viewController?.loadRequest(for: deviceTokenString)
        deviceTokenString = deviceToken.map{String(format: "%02,2hhx", $0)}.joined()
        print(deviceTokenString)
    }

    internal func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
  
    private func application(_ application: UIApplication, didReceiveRemoteNotifications userinfo:[AnyHashable : Any]) {
        
    }
    
    func settingPushNotification() {
        let app = UIApplication.shared
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            app.registerUserNotificationSettings(settings)
        }
        
        app.registerForRemoteNotifications()
    }
}

