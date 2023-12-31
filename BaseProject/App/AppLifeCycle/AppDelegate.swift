//
//  AppDelegate.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 31/12/2023.
//

import SwiftUI

/// https://developer.apple.com/documentation/swiftui/uiapplicationdelegateadaptor
/// Khi AppDelegate conform ObservableObject thì SwiftUI sẽ tự đưa nó vào Environment
/// Khi sử dụng chỉ đơn giản khai báo @EnvironmentObject private var appDelegate: AppDelegate (tương tự với SceneDelegate)
/// Nếu chỉ cần support từ iOS 17 thì thay thế ObservableObject bằng Observable macros mới hơn.
final class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    // MARK: - UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfiguration: UISceneConfiguration = .init(name: connectingSceneSession.configuration.name, sessionRole: connectingSceneSession.role)
        sceneConfiguration.delegateClass = SceneDelegate.self
        return sceneConfiguration
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
}

/*
 Thực tế thì hầu hết các ứng dụng (Không phải Demo Apps) đều cần đến AppDelegate để handle các công việc không thể thiếu
 như Notification, Home Screen Action mà SwiftUI hiện tại chưa support cách implement mới
 Tuy nhiên với những thứ đã support thì hạn chế sử dụng cách cũ với các func trong Delegate
 Ví dụ: nên sử dụng @Environment(\.scenePhase) private var scenePhase thay vì func applicationDidBecomeActive(_ application: UIApplication) trong AppDelegate (như link bên trên của Apple cũng đã đề cập)
 */
