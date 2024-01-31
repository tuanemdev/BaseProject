//
//  HomeDestination.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 29/01/2024.
//

import SwiftUI

/// Hoàn toàn tương tự cho các NavigationStack còn lại
/// Sử dụng cách tách router thành 1 cụm riêng biệt và sử dụng 1 Enum cho cả 1 NavigationStack đang có 1 nhược điểm chưa tìm ra cách giải quyết tối ưu
/// đó là khi cần truyền Binding data hoặc truyền action sang cho View khác
/// còn truyền data thông thường thì đưa vào Associated Values của Enum là dùng bình thường
#warning("Tìm cách viết router tốt hơn cho vấn đề bên trên")
// MARK: - Value
enum HomeDestination: Hashable {
    case resources
    case language
    case modifier
    case metaShader
    case mvArchitecture
}

// MARK: - Destination
extension View {
    @ViewBuilder
    func view(for destination: HomeDestination) -> some View {
        switch destination {
        case .resources:
            ResourcesView()
        case .language:
            LocalizableView()
        case .modifier:
            StyleView()
        case .metaShader:
            CirclePattern()
        case .mvArchitecture:
            MVArchitecture()
        }
    }
}
