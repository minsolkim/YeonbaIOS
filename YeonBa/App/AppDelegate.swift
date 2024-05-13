//
//  AppDelegate.swift
//  YeonBa
//
//  Created by 김민솔 on 2024/02/29.
//

import UIKit
import KakaoSDKCommon
import FirebaseCore
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        var token: String = ""
        for i in 0..<deviceToken.count {
            token += String(format: "%02.2hhx", deviceToken[i] as CVarArg)
        }
        print("token : \(token)")
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 1. 푸시 권한 요청
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            print(granted)
        }
        // 파이어베이스 설정
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        
        // 앱 실행 시 사용자에게 알림 허용 권한을 받는다.
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in}
        )
        // 2. device 토큰 획득: application(_:didRegisterForRemoteNotificationsWithDeviceToken:) 메소드 호출
        application.registerForRemoteNotifications()
        KakaoSDK.initSDK(appKey: "e6b04f788417448d57a296f48140dfcb")
        // Override point for customization after application launch.
        return true
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
extension AppDelegate: MessagingDelegate {
    // FCM Token 업데이트 시
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("🥳", #function, fcmToken ?? "nil")
        let userInfo: [String: Any] = ["fcmToken": fcmToken ?? ""]
        print(userInfo)
    }
    
    // error 발생 시
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("😭", error)
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    // 앱 화면을 보고있는 중(포그라운드)에 푸시 올 때
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        print("😎", #function)
        
        // 푸시 알림 데이터가 userInfo에 담겨있다.
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        
        // 푸시 알림 내용을 인코딩하여 출력
        if let aps = userInfo["aps"] as? [String: Any],
           let alert = aps["alert"] as? [String: Any],
           let title = alert["title"] as? String,
           let body = alert["body"] as? String {
               if let encodedTitle = title.data(using: .utf8),
                  let encodedBody = body.data(using: .utf8),
                  let decodedTitle = String(data: encodedTitle, encoding: .utf8),
                  let decodedBody = String(data: encodedBody, encoding: .utf8) {
                      print("Encoded Title: \(title)")
                      print("Encoded Body: \(body)")
                      print("Decoded Title: \(decodedTitle)")
                      print("Decoded Body: \(decodedBody)")
               }
        }
        
        if #available(iOS 14.0, *) {
            return [.sound, .banner, .list]
        } else {
            return []
        }
    }

}
extension AppDelegate {
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Push notification received:")
        print(userInfo)
        if let message = userInfo["message"] as? String {
            let notificationInfo: [String: Any] = ["message": message]
            print(notificationInfo)
        }
        completionHandler(.newData)
    }
}

