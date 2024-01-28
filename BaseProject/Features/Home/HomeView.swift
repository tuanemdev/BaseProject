//
//  ContentView.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 24/12/2023.
//

import SwiftUI

struct HomeView: View {
    @State private var activeTabItem: TabItem = .home
    @State private var tabItemPosition: CGPoint = .zero
    @Namespace private var animation
    
    init() {
        setupGlobalUIAppearance()
    }
    
    var body: some View {
        TabView(selection: $activeTabItem) {
            NavigationStack {
                HomeBaseView()
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBar { navi in
                        navi.navigationBar.layer.masksToBounds = false
                        navi.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
                        navi.navigationBar.layer.shadowOpacity = 3.0
                        navi.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 4.0)
                        navi.navigationBar.layer.shadowRadius = 4
                        navi.navigationBar.topItem?.backButtonDisplayMode = .minimal
                    }
            }
            .tag(TabItem.home)
            
            NavigationStack {
                ServicesView()
            }
            .tag(TabItem.services)
            
            NavigationStack {
                PartnersView()
            }
            .tag(TabItem.partners)
            
            NavigationStack {
                ActivityView()
            }
            .tag(TabItem.activity)
        }
        .tabViewStyle(.automatic) /// Đang có lỗi với NavigationStack khi nhúng trong Tabbar dùng với chế độ page
        .scrollContentBackground(.hidden)
        .safeAreaInset(edge: .bottom) {
            customTabbar()
        }
        .ignoresSafeArea(.keyboard)
    }
    
    @ViewBuilder
    private func customTabbar(_ activeTint: Color = .blue, _ inactiveTint: Color = .teal) -> some View {
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(TabItem.allCases, id: \.rawValue) { tabItem in
                TabItemView(
                    activeTint: activeTint,
                    inactiveTint: inactiveTint,
                    tabItem: tabItem,
                    animation: animation,
                    activeTabItem: $activeTabItem,
                    position: $tabItemPosition
                )
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background {
            TabItemShape(midPoint: tabItemPosition.x)
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
                .shadow(color: activeTint.opacity(0.5), radius: 5, x: 0, y: -5)
                .padding(.top, 25)
        }
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: activeTabItem)
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: tabItemPosition)
    }
    
    private func setupGlobalUIAppearance() {
        /// Fix Bug SwiftUI in iOS 16, TabBar sẽ ngẫu nhiên hiển thị khi chuyển giữa các tab
        /// Nếu dùng hàm này thì không cần sử dụng .toolbar(.hidden, for: .tabBar)
        UITabBar.appearance().isHidden = true
        /// NavigationBar
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundImage = UIImage(resource: .naviBackground)
        appearance.backgroundImageContentMode = .scaleToFill
        appearance.shadowColor = .gray
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.baseTitle,
            .font: UIFontMetrics.default.scaledFont(for: UIFont(name: Fonts.sixtyfourOverlapping, size: 14)!),
        ]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

#Preview {
    HomeView()
}
