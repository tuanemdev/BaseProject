//
//  StyleView.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 23/01/2024.
//

import SwiftUI

struct StyleView: View {
    @State private var isCoder: Bool = true
    @State private var textContent: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ScrollView {
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
            
            /// Label
            FlowLayout(spacing: 10) {
                ForEach(StyleView.tags, id: \.title) { tag in
                    Label(tag.title, systemImage: tag.icon)
                        .labelStyle(.socialFeedTag)
                }
            }
            
            /// TextField
            TextField(text: $textContent, prompt: Text("Search...")) {
                Label("Google", systemImage: "magnifyingglass")
            }
            .textFieldStyle(.baseStyle)
            .padding()
            
            SecureField(text: $password, prompt: Text("Enter password")) {
                Label("Pass Code", systemImage: "lock.shield")
            }
            .textFieldStyle(.baseStyle)
            .padding(.horizontal)
        }
    }
}

#Preview {
    StyleView()
}

extension StyleView {
    struct Tag {
        let title: String
        let icon: String
    }
    
    static let tags: [Tag] = [
        .init(title: "Share", icon: "square.and.arrow.up"),
        .init(title: "Write", icon: "pencil.and.scribble"),
        .init(title: "Folder", icon: "folder.fill.badge.gearshape"),
        .init(title: "Save", icon: "tray.and.arrow.down.fill"),
        .init(title: "Storage", icon: "internaldrive.fill"),
        .init(title: "Info", icon: "person.crop.square.filled.and.at.rectangle.fill"),
        .init(title: "Run", icon: "figure.walk.motion")
    ]
}
