//
//  AppDelegate.swift
//  MyBookStore
//
//  Created by Douglas Spencer on 10/17/20.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound, .carPlay]) { (granted, error) in
            if error == nil {
                //If there is no error, we can check the granted variable
                debugPrint("Granted:\(granted)")
                
                //Show Current Notification Settings
                self.getNotificationSettings()
        
                let currentAction = UNNotificationAction(identifier: "goToCurrentBooksAction", title: "Go To Current", options: [.foreground])
                let currentCateogry = UNNotificationCategory(identifier: "CURRENT_BOOKS", actions: [currentAction], intentIdentifiers: [],options: [])
                
                let newArrivalsAction = UNNotificationAction(identifier: "goToNewArrivalsAction", title: "Go To New Arrivals", options: [.foreground])
                let newArrivalsCategory = UNNotificationCategory(identifier: "NEW_ARRIVAL", actions: [newArrivalsAction], intentIdentifiers: [], options: [])
                
                let settingsAction = UNNotificationAction(identifier: "goToSettingsAction", title: "Go To Settings", options: [.foreground])
                let settingsCategory = UNNotificationCategory(identifier: "SETTINGS", actions: [settingsAction], intentIdentifiers: [], options: [])
                
                UNUserNotificationCenter.current().setNotificationCategories([currentCateogry, newArrivalsCategory, settingsCategory])
                
            }
        }
        return true
    }
    
    fileprivate func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("My Current Notification Settings: \(settings)")
            
            if settings.authorizationStatus == .authorized {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                    
                    UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                        print("My Current Notification Settings: \(settings)")
                        
                        if settings.authorizationStatus == .authorized {
                            DispatchQueue.main.async {
                                UIApplication.shared.registerForRemoteNotifications()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        debugPrint("Successfully Registered For Remote Push Notifications...")
        let tokenparts = deviceToken.map {Data in String(format: "%02.hhx", Data)}
        let token = tokenparts.joined()
        debugPrint(token)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        debugPrint("Did Not Register For Remote Notifications")
        debugPrint(error.localizedDescription)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        let apns = APNSPayload(apnsDict: userInfo)
        
        switch apns.category {
            case "SALE":
                NotificationCenter.default.post(name: .didRecieveSale, object: nil)
            case "SETTINGS":
                NotificationCenter.default.post(name: .didRecieveSetting, object: nil)
            case "NEWARRIVAL":
                NotificationCenter.default.post(name: .didRecieveNewArrival, object: nil)
            default:
                NotificationCenter.default.post(name: .didRecieveSale, object: nil)
        }
        
        completionHandler(.newData)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let ui = response.notification.request.content.userInfo
        
        let aps = ui["aps"]
        
        
        let tabBarController = (UIApplication.shared.windows[0].rootViewController) as? UITabBarController?
        tabBarController??.selectedIndex = 2
        
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}
