//
//  Router.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 29/01/2024.
//

import SwiftUI
import Observation

@Observable
final class Router {
    /// Tabbar
    var activeTabItem: TabItem = .home
    /// 4 NavigationStack
    var homePath: NavigationPath = .init()
    var servicesPath: NavigationPath = .init()
    var partnersPath: NavigationPath = .init()
    var activityPath: NavigationPath = .init()
    
    /// Logic ở đây chỉ là viết tạm cho homePath và đang không tương tác gì với nhau (tương tác giữa Tabbar và 4 NavigationStack với nhau).
    /// Tùy thuộc vào dự án mà viết hàm routing cho phù hợp
    func changeTab(to tab: TabItem) {
        activeTabItem = tab
    }
    
    func navigate(to destination: HomeDestination) {
        homePath.append(destination)
    }
    
    func back() {
        homePath.removeLast()
    }
    
    func backToRoot() {
        homePath.removeLast(homePath.count)
    }
}
