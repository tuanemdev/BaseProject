//
//  AppDelegate.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 31/12/2023.
//

import SwiftUI
import Observation

/// https://developer.apple.com/documentation/swiftui/uiapplicationdelegateadaptor
/// Khi AppDelegate conform @Observable thì SwiftUI sẽ tự đưa nó vào Environment
/// Khi sử dụng chỉ đơn giản khai báo @Environment(AppDelegate.self) private var appDelegate (tương tự với SceneDelegate)
/// Đây là dành cho iOS 17 trở lên vì Observation không được backDeploy. Đời cũ thì thay thế Observable bằng ObservableObject, hoàn toàn tương tự.
@Observable
final class AppDelegate: NSObject, UIApplicationDelegate {
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
