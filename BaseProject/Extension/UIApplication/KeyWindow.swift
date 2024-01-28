//
//  KeyWindow.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 28/01/2024.
//

import SwiftUI

extension UIApplication {
    var appKeyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first?
            .keyWindow
    }
    
    func changeRoot<Content>(to view: Content) where Content: View {
        UIApplication.shared.appKeyWindow?.rootViewController = UIHostingController(rootView: view)
    }
}
