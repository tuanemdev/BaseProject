//
//  EnvironmentsView.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 26/02/2024.
//

import SwiftUI

struct EnvironmentsView: View {
    @State private var showLogScreen: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                Text(ConfigurationProvider.baseURL)
                Text(ConfigurationProvider.secretKey)
            }
            .paddingForNavigationBarAndTabbar()
            .frame(maxWidth: .infinity)
        }
        .background(Color.baseBackground)
        .navigationTitleView(
            title: "Environments Manager",
            subTitle: "DEV - STAG - PROD",
            icon: "doc.badge.gearshape.fill"
        )
        .fullScreenCover(isPresented: $showLogScreen) {
            LoggingView(isPresented: $showLogScreen)
        }
        .onShake {
            #if DEBUG
            showLogScreen.toggle()
            #endif
        }
    }
}

#Preview {
    EnvironmentsView()
}
