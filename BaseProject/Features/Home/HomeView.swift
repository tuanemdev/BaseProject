//
//  ContentView.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 24/12/2023.
//

import SwiftUI

struct HomeView: View {
    @State private var router: Router = .init()
    @State private var tabItemPosition: CGPoint = .zero
    @Namespace private var animation
    
    init() {
        setupGlobalUIAppearance()
    }
    
    var body: some View {
        TabView(selection: $router.activeTabItem) {
            NavigationStack(path: $router.homePath) {
                HomeBaseView()
                    .navigationDestination(for: HomeDestination.self, destination: view(for:))
                    .commonNavigationBar()
            }
            .tag(TabItem.home)
            
            NavigationStack(path: $router.servicesPath) {
                ServicesView()
                    .commonNavigationBar()
            }
            .tag(TabItem.services)
            
            NavigationStack(path: $router.partnersPath) {
                PartnersView()
                    .commonNavigationBar()
            }
            .tag(TabItem.partners)
            
            NavigationStack(path: $router.activityPath) {
                ActivityView()
                    .commonNavigationBar()
            }
            .tag(TabItem.activity)
        }
        .tabViewStyle(.automatic) /// Đang có lỗi với NavigationStack khi nhúng trong Tabbar dùng với chế độ page
        .scrollContentBackground(.hidden)
        .safeAreaInset(edge: .bottom) {
            customTabbar()
        }
        .ignoresSafeArea(.keyboard)
        .environment(router)
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
                    activeTabItem: $router.activeTabItem,
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
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: router.activeTabItem)
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: tabItemPosition)
    }
    
    private func setupGlobalUIAppearance() {
        /// Fix Bug SwiftUI in iOS 16, TabBar sẽ ngẫu nhiên hiển thị khi chuyển giữa các tab
        /// Nếu dùng hàm này thì không cần sử dụng .toolbar(.hidden, for: .tabBar)
        UITabBar.appearance().isHidden = true
        
        /// NavigationBar
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        /// transitionMaskImage nếu set đúng sẽ không giống với backIndicatorImage, tác dụng của nó là những phần không trong suốt sẽ nhìn thấy text khi chuyển màn
        /// https://sarunw.com/posts/what-is-backindicatortransitionmaskimage/
        let backIndicatorImage = UIImage(systemName: "arrowtriangle.backward.fill")?.withTintColor(.baseTitle, renderingMode: .alwaysOriginal)
        appearance.setBackIndicatorImage(backIndicatorImage, transitionMaskImage: backIndicatorImage)
        /// Chưa tìm được cách ẩn back button title, cho dù đã set backButtonDisplayMode = .minimal
        /// Dùng thủ thuật bằng cách chuyển foregroundColor về clear và rời vị trí sang bên trái 40 point
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [
            .foregroundColor : UIColor.clear,
            .font : UIFont.systemFont(ofSize: 18) /// Đổi size luôn của cả backIndicatorImage vì nó là SF Symbol
        ]
        backButtonAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: -40, vertical: 0)
        appearance.backButtonAppearance = backButtonAppearance
        appearance.backgroundImage = UIImage(resource: .naviBackground)
        appearance.backgroundImageContentMode = .scaleToFill
        appearance.shadowColor = .gray
        appearance.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -8)
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.baseTitle,
            .font: UIFontMetrics.default.scaledFont(for: UIFont(name: Fonts.sixtyfourOverlapping, size: 14)!),
        ]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactScrollEdgeAppearance = appearance
    }
}

#Preview {
    HomeView()
}
