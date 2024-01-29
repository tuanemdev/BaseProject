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
    /// + Ưu điểm của NavigationPath là nó có thể chứa nhiều loại Hashable cho các destination thông qua các .navigationDestination(for: ,destination:)
    /// + Còn với custom data như với mảng HomeDestination thì chỉ chấp nhận kiểu HomeDestination trong Stack
    ///   nhưng có thể kiểm soát nhiều hơn do biết chính xác kiểu dữ liệu và có đủ các func support cho một Array,
    ///   tuy nhiên không nên lạm dụng để đảm bảo nguyên tắc hoạt động của Stack là chỉ có push và pop (LIFO - Last In First Out)
    var homePath: [HomeDestination] = .init()
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
        guard !homePath.isEmpty else { return }
        homePath.removeLast()
        /// có thể sử dụng homePath.popLast() cho an toàn và không cần check empty tuy nhiên NavigationPath không có func này nên sử dụng .removeLast() cho đồng bộ
    }
    
    func back(to destination: HomeDestination) {
        guard let firstIndex = homePath.firstIndex(of: destination) else { return }
        let viewsCount: Int = (homePath.count - 1) - firstIndex
        homePath.removeLast(viewsCount)
    }
    
    func backToRoot() {
        homePath.removeLast(homePath.count)
    }
}
