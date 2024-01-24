//
//  BaseTextFieldStyle.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 24/01/2024.
//

import SwiftUI

// MARK: - Style
/// Khác với các Style khác, protocol TextFieldStyle không bộc lộ func để implement nó
struct BaseTextFieldStyle: TextFieldStyle {
    @FocusState private var isFocused: Bool
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        // let _ = print(configuration)
        let mirror = Mirror(reflecting: configuration)
        let text: Binding<String> = mirror.descendant("_text") as! Binding<String>
        let value: String = mirror.descendant("_text", "_value") as! String
        let _: Bool = mirror.descendant("isSecure") as! Bool
        let label: _TextFieldStyleLabel = mirror.descendant("label") as! _TextFieldStyleLabel
        let _: Axis = mirror.descendant("axis") as! Axis
        let _: Text? = mirror.descendant("prompt") as? Text
        
        return VStack(alignment: .leading) {
            label
                .font(.caption)
            
            configuration
                .focused($isFocused)
                .overlay(alignment: .trailing) {
                    if !value.isEmpty {
                        Button {
                            text.wrappedValue = String()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .tint(.primary)
                        }
                    }
                }
            
            Rectangle()
                .fill(isFocused ? Color.green : Color.gray)
                .frame(height: 1)
        }
    }
}

// MARK: - Extension
extension TextFieldStyle where Self == BaseTextFieldStyle {
    static var baseStyle: BaseTextFieldStyle { .init() }
}
