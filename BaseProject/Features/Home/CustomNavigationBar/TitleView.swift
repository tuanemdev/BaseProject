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
        }
        .offset(y: 8)
    }
}

// MARK: - Extension
extension View {
    func navigationTitleView(title: LocalizedStringKey, subTitle: LocalizedStringKey, icon: String) -> some View {
        toolbar {
            ToolbarItem(placement: .principal) {
                TitleView(title: title, subTitle: subTitle, icon: icon)
            }
        }
    }
}
