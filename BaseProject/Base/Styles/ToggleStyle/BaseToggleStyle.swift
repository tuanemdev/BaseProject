//
//  BaseToggleStyle.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 23/01/2024.
//

import SwiftUI

// MARK: - Style
struct BaseToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

// MARK: - Extension
extension ToggleStyle where Self == BaseToggleStyle {
    static var baseStyle: BaseToggleStyle { BaseToggleStyle() }
}
