//
//  StyleView.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 23/01/2024.
//

import SwiftUI

struct StyleView: View {
    @State private var isCoder: Bool = true
    
    var body: some View {
        /// Button
        Button(role: .cancel) {
            print("Hello Kitty")
        } label: {
            Label("Custom Button", systemImage: "gamecontroller.fill")
        }
        .buttonStyle(.baseStyle)
        
        /// Toggle
        Toggle(isOn: $isCoder) {
            Text("DEV")
        }
        .toggleStyle(.baseStyle)
    }
}

#Preview {
    StyleView()
}
