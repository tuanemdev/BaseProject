//
//  WrappedTextFieldStyle.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 24/01/2024.
//

import SwiftUI

// MARK: - WrappedTextFieldStyle Protocol
protocol WrappedTextFieldStyle {
    associatedtype Body : View
    
    @ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body
    
    typealias _TextField = TextField<_TextFieldStyleLabel>
    typealias Configuration = WrappedTextFieldStyleConfiguration<_TextField>
}

struct WrappedTextFieldStyleConfiguration<TextField: View> {
    let textField: TextField
    let text: Binding<String>
    let value: String
    let isSecure: Bool
    let label: _TextFieldStyleLabel
    let axis: Axis
    let prompt: Text?
}

// MARK: - TextFieldBridgingStyle
struct TextFieldBridgingStyle<Style: WrappedTextFieldStyle>: TextFieldStyle {
    let style: Style
    
    func _body(configuration: TextField<_Label>) -> some View {
        let mirror = Mirror(reflecting: configuration)
        let text: Binding<String> = mirror.descendant("_text") as! Binding<String>
        let value: String = mirror.descendant("_text", "_value") as! String
        let isSecure: Bool = mirror.descendant("isSecure") as! Bool
        let label: _TextFieldStyleLabel = mirror.descendant("label") as! _TextFieldStyleLabel
        let axis: Axis = mirror.descendant("axis") as! Axis
        let prompt: Text? = mirror.descendant("prompt") as? Text
        
        let wrappedConfiguration = WrappedTextFieldStyleConfiguration(
            textField: configuration,
            text: text,
            value: value,
            isSecure: isSecure,
            label: label,
            axis: axis,
            prompt: prompt
        )
        
        return style.makeBody(configuration: wrappedConfiguration)
    }
}

// MARK: - Extension View Modifier
extension View {
    func wrappedTextFieldStyle<S: WrappedTextFieldStyle>(_ style: S) -> some View {
        textFieldStyle(TextFieldBridgingStyle(style: style))
    }
}
