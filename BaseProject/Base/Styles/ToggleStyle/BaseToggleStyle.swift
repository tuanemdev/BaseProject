//
//  BaseToggleStyle.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 23/01/2024.
//

import SwiftUI

// MARK: - Style
struct BaseToggleStyle: ToggleStyle {
    let onImage: String
    let offImage: String
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 30)
                .fill(configuration.isOn ? .orange : Color(.systemGray5))
                .overlay {
                    Image(systemName: configuration.isOn ? onImage : offImage)
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .padding(8)
                        .rotationEffect(.degrees(configuration.isOn ? 0 : -360))
                        .offset(x: configuration.isOn ? 10 : -10)
                }
                .frame(width: 50, height: 32)
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}

// MARK: - Extension
extension ToggleStyle where Self == BaseToggleStyle {
    static var baseStyle: BaseToggleStyle { .init(onImage: "checkmark.circle.fill", offImage: "minus.circle.fill") }
}
