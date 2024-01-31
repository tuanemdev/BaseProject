//
//  TitleView.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 28/01/2024.
//

import SwiftUI

// MARK: - TitleView
struct TitleView: View {
    let title: LocalizedStringKey
    let subTitle: LocalizedStringKey
    let icon: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.custom(Fonts.sixtyfourOverlapping, size: 14, relativeTo: .title))
                .foregroundStyle(Color.baseTitle)
            
            Label(subTitle, systemImage: icon)
                .labelStyle(.titleAndIcon)
                .font(.footnote)
                .foregroundStyle(Color.secondary.gradient)
        }
        .offset(y: 8)
    }
}

// MARK: - Extension
extension View {
    /// Cách hoạt động của func này về bản chất khác với navigationTitle gốc của SwiftUI, chúng sử dụng Preferences. sẽ tìm các modifier trong tương lai nếu có thời gian
    func navigationTitleView(title: LocalizedStringKey, subTitle: LocalizedStringKey, icon: String) -> some View {
        toolbar {
            ToolbarItem(placement: .principal) {
                TitleView(title: title, subTitle: subTitle, icon: icon)
            }
        }
    }
}
