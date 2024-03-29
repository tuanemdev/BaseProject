//
//  PaddingContent.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 28/01/2024.
//

import SwiftUI

extension View {
    /// Mục đích để giãn cách ở NavigationBar 1 đoạn và giãn cách với CustomTabbar
    /// để  không bị Tabbar che mất nội dung
    func paddingForNavigationBarAndTabbar() -> some View {
        padding(EdgeInsets(top: 20, leading: 0, bottom: 100, trailing: 0))
    }
}
