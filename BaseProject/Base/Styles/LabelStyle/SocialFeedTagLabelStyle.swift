//
//  SocialFeedTagLabelStyle.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 24/01/2024.
//

import SwiftUI

// MARK: - Style
struct SocialFeedTagLabelStyle: LabelStyle {
    @ScaledMetric(relativeTo: .footnote) private var iconWidth = 14.0
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon
                .foregroundColor(.secondary)
                .frame(width: iconWidth)
            configuration.title
        }
        .padding(6)
        .background(in: RoundedRectangle(cornerRadius: 5, style: .continuous))
        .compositingGroup()
        .shadow(radius: 1)
        .font(.caption)
    }
}

// MARK: - Extension
extension LabelStyle where Self == SocialFeedTagLabelStyle {
    static var socialFeedTag: SocialFeedTagLabelStyle { .init() }
}
