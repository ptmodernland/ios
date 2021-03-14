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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    weak var viewController: LoginViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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
        print(deviceToken)
        let deviceTokenString: String = ( deviceToken.description as String )
        print(deviceTokenString)
        viewController?.loadRequest(for: deviceTokenString)
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

