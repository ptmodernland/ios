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
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    var window: UIWindow?
    var deviceTokenString=""
    let gcmMessageIDKey = "gcm.message_id"
    weak var viewController: LoginViewController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        NFX.sharedInstance().start()
        
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
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        
        let vc = StoryboardScene.Login.loginViewController.instantiate()
        window?.rootViewController = vc
        return true
    }
    
    func application(_ application: UIApplication,
                     didReceiveRegistrationToken deviceToken: Data) {
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FCM registration token: \(token)")
            }
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        
        let dataDict:[String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        //viewController?.loadRequest(for: fcmToken ?? "")
        UserDefaults.standard.set(fcmToken ?? "", forKey: "fcmToken")
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        _ = notification.request.content.userInfo
        completionHandler([[.alert, .sound]])
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let targetValue = userInfo["target"] as? String
        {
            coordinateToSomeVC(targetValue: targetValue, idIom: userInfo["idnya"] as? String ?? "")
        }
        completionHandler()
    }
    
    private func coordinateToSomeVC(targetValue: String, idIom : String) {
        guard let window = UIApplication.shared.keyWindow else { return }
        
        //var storyboard = UIStoryboard(name: "Comparasion", bundle: nil)
        //var yourVC = storyboard.instantiateViewController(identifier: "ListCompareViewController")
        if(targetValue == "iom"){
            let levelHead = UserDefaults().string(forKey: "level")
            if levelHead == "shead" {
                //storyboard = UIStoryboard(name: "IOM", bundle: nil)
                let VC = StoryboardScene.IOM.detailIOMViewController.instantiate()
                VC.idIom = Int(idIom) ?? 0
                VC.fromPushNotif = true
                let navController = UINavigationController(rootViewController: VC)
                navController.setNavigationBarHidden(true, animated: true)
//                navController.modalPresentationStyle = .fullScreen
                window.rootViewController = navController
//                window.makeKeyAndVisible()
            } else {
                let VC = StoryboardScene.IOM.listIOMViewController.instantiate()
                let navController = UINavigationController(rootViewController: VC)
                navController.setNavigationBarHidden(true, animated: true)
//                navController.modalPresentationStyle = .fullScreen
                window.rootViewController = navController
//                window.makeKeyAndVisible()
            }
             //storyboard = UIStoryboard(name: "IOM", bundle: nil)
             //yourVC = storyboard.instantiateViewController(identifier: "IOMViewController")
        } else if(targetValue == "pbj"){
            let VC = StoryboardScene.PBJ.listPBJViewController.instantiate()
            let navController = UINavigationController(rootViewController: VC)
            navController.setNavigationBarHidden(true, animated: true)
//                navController.modalPresentationStyle = .fullScreen
            window.rootViewController = navController
//            window.makeKeyAndVisible()
        }
        
    }
    
    func application(_ xapplication: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
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

