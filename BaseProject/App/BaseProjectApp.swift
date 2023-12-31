//
//  BaseProjectApp.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 24/12/2023.
//

import SwiftUI

@main
struct BaseProjectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
