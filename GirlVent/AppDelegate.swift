//
//  AppDelegate.swift
//  Girlvent
//
//  Created by Glasier Inc. on 17/12/19.
//  Copyright © 2019 Glasier Inc. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import UserNotifications
import FirebaseInstanceID
import FirebaseMessaging
import BRYXBanner
var userdefault =  UserDefaults.standard
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate, MessagingDelegate{


        var window: UIWindow?
        var toekn = ""

        var BodyMesssgae = ""
    var navigationController: UINavigationController = UINavigationController()
           let gcmMessageIDKey = "gcm.message_id"
    
           class var shared : AppDelegate {
                return UIApplication.shared.delegate as! AppDelegate
            }
            
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
            FirebaseApp.configure()
        
        
               IQKeyboardManager.shared.enable = true
             Thread.sleep(forTimeInterval: 3.0)
        
        
        
            if let selectedLanguage = GLocalization.sharedInstance.getLanguage()
            {
                GLocalization.sharedInstance.setLanguage(language: selectedLanguage)
            }
            else
            {
//                let language = Locale.preferredLanguages[0]//NSLocale.current.languageCode!
//                let languageDic = NSLocale.components(fromLocaleIdentifier: language) as NSDictionary
//                let languageCode = languageDic.object(forKey: "kCFLocaleLanguageCodeKey") as! String
//                if Languages.isLanguageAvailable(languageCode)
//                {
//                    GLocalization.sharedInstance.setLanguage(language: languageCode)
//                }
//                else
//                {
                    GLocalization.sharedInstance.setLanguage(language: "en")
//                }
                
            }
            
       
        
     
        if #available(iOS 13, *) {
          // do nothing / do things that should only be done for iOS 13
            
        } else {
          
          if UserDefaults.standard.data(forKey:USER_LOGIN) == nil{
              
                              let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                        let DashboardVC = storyboard.instantiateViewController(withIdentifier: "LoginVcPuch") as! LoginVc
                                        let navigationController = UINavigationController(rootViewController: DashboardVC)
                                        navigationController.navigationBar.isTranslucent = false
                                        navigationController.navigationBar.isHidden = true
                                        self.window?.rootViewController = navigationController
                                          self.window?.makeKeyAndVisible()
          }
            
        }
             
             UNUserNotificationCenter.current().delegate = self
             // iOS 10 support
             if #available(iOS 10, *)
             {
                 UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
                 application.registerForRemoteNotifications()
                 
             }
                 // iOS 9 support
             else if #available(iOS 9, *)
             {
                 UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
                 UIApplication.shared.registerForRemoteNotifications()
             }
             // iOS 8 support
             else if #available(iOS 8, *)
             {
                 UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
                 UIApplication.shared.registerForRemoteNotifications()
             }
             // iOS 7 support
             else
             {
                 application.registerForRemoteNotifications(matching: [.badge, .sound, .alert])
             }
                  Messaging.messaging().delegate = self
             application.registerForRemoteNotifications()
             Messaging.messaging().isAutoInitEnabled = true
         
                     NotificationCenter.default.addObserver(self, selector: #selector(self.tokenRefreshNotification), name: NSNotification.Name.InstanceIDTokenRefresh, object: nil)
        return true
    }
        @objc func tokenRefreshNotification(_ notification: Notification) {
            print(#function)
            InstanceID.instanceID().instanceID { (result, error) in
                if let error = error
                {
                    print("Error fetching remote instange ID: \(error)")
                }
                else if let result = result
                {
                    print("Remote instance ID token: \(result.token)")
                    self.toekn = "\(result.token)"
                }
            }
            // Connect to FCM since connection may have failed when attempted before having a token.
            connectToFcm()
        }
        func connectToFcm() {
            // Won't connect since there is no token
             InstanceID.instanceID().instanceID { (result, error) in
                      if let error = error
                      {
                          print("Error fetching remote instange ID: \(error)")
                      }
                      else if let result = result
                      {
                          print("Remote instance ID token: \(result.token)")
                          self.toekn = "\(result.token)"
                      }
                  }
            
            Messaging.messaging().shouldEstablishDirectChannel = true
        }
      func instanceID(handler: @escaping InstanceIDResultHandler)
         {
             InstanceID.instanceID().instanceID { (result, error) in
                 if let error = error
                 {
                     print("Error fetching remote instange ID: \(error)")
                 }
                 else if let result = result
                 {
                     print("Remote instance ID token: \(result.token)")
                     self.toekn = "\(result.token)"
                 }
             }
         }
          // self.udateUI() // Add code to show a specific view on tap.
         @objc func pushNotificationHandler(_ notification : NSNotification)
         {
    //         let viewController = GuessViewController(nibName:"GuessViewController", bundle:nil)
    //         let navigationController = UINavigationController.init(rootViewController: viewController)
    //         self.window!.rootViewController = navigationController
    //         self.window!.makeKeyAndVisible()
         }
         func registerForPushNotifications()
         {
             UNUserNotificationCenter.current()
                 .requestAuthorization(options: [.alert, .sound, .badge]) {
                     [weak self] granted, error in
                     
                     print("Permission granted: \(granted)")
                     guard granted else { return }
                     self?.getNotificationSettings()
             }
         }
         func getNotificationSettings()
         {
             UNUserNotificationCenter.current().getNotificationSettings { settings in
                 print("Notification settings: \(settings)")
                 guard settings.authorizationStatus == .authorized else { return }
                 DispatchQueue.main.async {
                     UIApplication.shared.registerForRemoteNotifications()
                 }
             }
         }
        func applicationWillResignActive(_ application: UIApplication) {
               // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
               // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
           }

           func applicationDidEnterBackground(_ application: UIApplication) {
               // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
               // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
           }

           func applicationWillEnterForeground(_ application: UIApplication) {
               // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
           }

           func applicationDidBecomeActive(_ application: UIApplication) {
               // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
            
           }

           func applicationWillTerminate(_ application: UIApplication) {
               // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
           }
           func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String)
           {
               print("Firebase registration token: \(fcmToken)")
               let dataDict:[String: String] = ["token": fcmToken]
               NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
               InstanceID.instanceID().instanceID { (result, error) in
                   if let error = error
                   {
                       print("Error fetching remote instange ID: \(error)")
                       self.toekn = "I ERROR!  Error fetching remote instange ID: \(error)"
                   }
                   else if let result = result
                   {
                       print("Remote instance ID token: \(result.token)")
                       self.toekn = "\(result.token)"
                   }
               }
               // TODO: If necessary send token to application server.
               // Note: This callback is fired at each app startup and whenever a new token is generated.
           }
        func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
              print("Received data message: \(remoteMessage.appData)")
          }
           func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error)
           {
               print("i am not available in simulator \(error)")
           }
           func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
           {
               Messaging.messaging().apnsToken = deviceToken
               InstanceID.instanceID().instanceID { (result, error) in
                   if let error = error
                   {
                       print("Error fetching remote instange ID: \(error)")
                       self.toekn = "Error fetching remote instange ID: \(error)"
                   }
                   else if let result = result
                   {
                       print("Remote instance ID token: \(result.token)")
                       self.toekn = "\(result.token)"
                   }
               }
           }
           func application(_ application: UIApplication,didReceiveRemoteNotification userInfo: [AnyHashable : Any],fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
           {
            Messaging.messaging().appDidReceiveMessage(userInfo)
            if let messageID = userInfo[gcmMessageIDKey] {
                      print("Message ID: \(messageID)")
                  }
            _ = userInfo["aps"] as! NSDictionary
            print(userInfo)
            
            
            
            
             switch application.applicationState {
                 
             case .inactive:
                 print("Inactive")
                 //Show the view with the content of the push
                 completionHandler(.newData)
                 
             case .background:
                 print("Background")
                 //Refresh the local model
                 completionHandler(.newData)
                 
             case .active:
                 print("Active")
                 
                 
                 
                 
                 
                 
                 
                 completionHandler(UIBackgroundFetchResult.newData)
             @unknown default: break
                
            }
            
    //        if UIApplication.shared.applicationState == UIApplication.State.active
    //           {
    //               let banner = Banner(title: "Tic Toc Doc", subtitle: aps.value(forKey: "alert") as? String , image: UIImage(named: "not"), backgroundColor: UIColor.lightGray)
    //               banner.dismissesOnTap = true
    //               banner.didTapBlock = {
    //               }
    //               banner.show(duration: 3.0)
    //           }
    //           else
    //           {
    //           }
    //           let alert = aps["alert"] as? NSDictionary
    //           let body = alert!["body"] as? String
    //           let title = alert!["title"] as? String
    //           self.BodyMesssgae = "\(body!)"
    //           UserDefaults.standard.set(title, forKey: "body")
           }
           public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping() -> Swift.Void)
           {
    //           let user:User = AppUtility.getSession()
    //
    //           if user.type == "1"
    //           {
    //               let viewController = QuestionAnswerViewController(nibName:"QuestionAnswerViewController", bundle:nil)
    //               let navigationController = UINavigationController.init(rootViewController: viewController)
    //               self.window!.rootViewController = navigationController
    //               self.window!.makeKeyAndVisible()
    //           }
    //           else
    //           {
    //               let viewController = GuessViewController(nibName:"GuessViewController", bundle:nil)
    //               let navigationController = UINavigationController.init(rootViewController: viewController)
    //               self.window!.rootViewController = navigationController
    //               self.window!.makeKeyAndVisible()
    //           }
            
            
            let userInfoa = response.notification.request.content.userInfo
                   // Print message ID.
                          let userInfo = response.notification.request.content.userInfo as NSDictionary
                   if let messageID = userInfoa[gcmMessageIDKey] {
                       print("Message ID: \(messageID)")
                   }
                  
                   // Print full message.
            
                   print("\(userInfo)")
            print(userInfo.description)
                 
                 completionHandler()
           }
        func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    willPresent notification: UNNotification,
                                    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
        {
            let userInfo = notification.request.content.userInfo
            
            if let aps = userInfo["aps"] as? NSDictionary
            {
                let alert = aps["alert"]as? NSDictionary
                _ = aps["badge"] as? Int
                let body = alert!["body"] as? String
                self.BodyMesssgae = "\(String(describing: body!))"
            }
            

                   
                   // With swizzling disabled you must let Messaging know about the message, for Analytics
                    Messaging.messaging().appDidReceiveMessage(userInfo)
                   // Print message ID.
                   if let messageID = userInfo[gcmMessageIDKey] {
                       print("Message ID: \(messageID)")
                   }
                   
                   // Print full message.
                   let userInfoasad = notification.request.content.userInfo as NSDictionary
            
            print("\(userInfoasad)")
                print(userInfo.description)
            completionHandler([.alert, .badge, .sound])
        }
    // MARK: UISceneSession Lifecycle
   @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
   @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Girlvent")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    

}

extension AppDelegate {
    
    func application(_ app: UIApplication,open url: URL,options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let userDefaults = UserDefaults(suiteName: "group.com.Glasierinc.Girlventdemo")
        
        let sharedArray = userDefaults?.object(forKey: "img") as? [String : Any]
        
        let dict: [String : Any] = sharedArray!
        
        
        print(dict["name"] as Any)
        
//        if let key = url.absoluteString.components(separatedBy: "=").last,
//            let sharedArray = userDefaults?.object(forKey: key) as? [Data] {
//
////            var imageArray: [CellModel] = []
////
////            for imageData in sharedArray {
////                let model = CellModel(image: UIImage(data: imageData)!)
////                imageArray.append(model)
////            }
////
//
//
//            return true
//        }
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                 let therapiescall = storyboard.instantiateViewController(withIdentifier: "CreateImagePostVCpuch") as! CreateImagePostVC

                            // let therapiescall = storyBoard.instantiateViewController(withIdentifier: "CreateImagePostVCpuch") as! CreateImagePostVC
                           //  self.navigationController?.pushViewController(therapiescall, animated: true)
                 
                 let navVC = storyboard.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
                 
                 navVC.viewControllers = [therapiescall]
                 self.window?.rootViewController = navVC
                 self.window?.makeKeyAndVisible()
        
        return true
    }
    
}
