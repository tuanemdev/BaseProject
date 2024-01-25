//
//  BasePrimitiveButtonStyle.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 25/01/2024.
//

import SwiftUI

// MARK: - Style
/// Sự khác biệt giữa PrimitiveButtonStyle và ButtonStyle là
/// + ButtonStyle có isPressed
/// + PrimitiveButtonStyle có trigger() để mình tự handle khi nào muốn thực hiện action của function
struct BasePrimitiveButtonStyle: PrimitiveButtonStyle {
    let color: Color
    @GestureState private var pressed = false
    
    func makeBody(configuration: Configuration) -> some View {
        let longPress = LongPressGesture(minimumDuration: 1.0, maximumDistance: 0.0)
            .updating($pressed) { value, state, _ in state = value }
            .onEnded { _ in
                configuration.trigger()
            }
        
        return configuration.label
            .foregroundColor(.white)
            .padding(15)
            .background(RoundedRectangle(cornerRadius: 5).fill(color))
            .compositingGroup()
            .shadow(color: .black, radius: 3)
            .opacity(pressed ? 0.8 : 1.0)
            .scaleEffect(pressed ? 0.9 : 1.0)
            .gesture(longPress)
    }
}

// MARK: - Extension
extension PrimitiveButtonStyle where Self == BasePrimitiveButtonStyle {
    static var basePrimitiveStyle: BasePrimitiveButtonStyle { .init(color: .pink) }
}
