//
//  HomeDestination.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 29/01/2024.
//

import SwiftUI

/// Hoàn toàn tương tự cho các NavigationStack còn lại
// MARK: - Value
enum HomeDestination {
    case resources
    case language
    case modifier
    case metaShader
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
        }
    }
}
