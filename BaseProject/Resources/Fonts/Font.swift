//
//  Font.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 28/01/2024.
//

/// Font Lib: https://fonts.google.com/
/// Add+ custom font: https://developer.apple.com/documentation/uikit/text_display_and_fonts/adding_a_custom_font_to_your_app

import SwiftUI

// MARK: - Print Fonts
extension View {
    func printFonts() {
        UIFont.familyNames.sorted().forEach { familyName in
            print("\n=== Family: \(familyName) ===\nFonts:")
            UIFont.fontNames(forFamilyName: familyName).enumerated().forEach { index, fontName in
                print("\t\(index). \(fontName)")
            }
        }
    }
}

// MARK: - Constant
/// Font - SwiftUI
extension Font {
    static let navigationTitle: Font = .custom("SixtyfourOverlapping-Regular", size: 14, relativeTo: .title)
}

/// UIFont - UIKit
extension UIFont {
    static let navigationTitle: UIFont = UIFontMetrics(forTextStyle: .title1).scaledFont(for: UIFont(name: "SixtyfourOverlapping-Regular", size: 14)!)
}
