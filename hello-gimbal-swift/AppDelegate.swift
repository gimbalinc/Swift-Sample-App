import UIKit
import UserNotifications
import Gimbal

@available(iOS 10.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate  {
    var notificationCenter : UNUserNotificationCenter!
    
    var window: UIWindow?
    
    @objc(application:didFinishLaunchingWithOptions:) internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil))
        
            notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.delegate = self as UNUserNotificationCenterDelegate
        
        Gimbal.setAPIKey("PASTE YOUR APPLICATION API KEY HERE", options: nil)
        
        return true
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                         willPresent notification: UNNotification,
                                         withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){
        completionHandler(.alert)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}

