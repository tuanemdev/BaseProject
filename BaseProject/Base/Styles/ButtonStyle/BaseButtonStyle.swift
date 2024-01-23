//
//  BaseButtonStyle.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 23/01/2024.
//

import SwiftUI

// MARK: - Style
struct BaseButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background {
                switch configuration.role {
                case .none:                 Color.green
                case .some(let role):       role == .cancel ? Color.gray : Color.pink
                }
            }
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

// MARK: - Extension
extension ButtonStyle where Self == BaseButtonStyle {
    static var baseStyle: BaseButtonStyle { BaseButtonStyle() }
}
