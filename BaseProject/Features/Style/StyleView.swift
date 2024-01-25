//
//  StyleView.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 23/01/2024.
//

import SwiftUI

/// Style hoạt động giống như environment, nên không nhất thiết mỗi lần dùng Components đều phải áp dụng style cho nó
/// mà nó sẽ áp dụng cho cả hệ thống View Hierarchy (hệ thống phân cấp view)
/// (thử cắt .toggleStyle(.baseStyle) rồi áp dụng vào HomeView() ở Root App để thấy kết quả không thay đổi)
struct StyleView: View {
    /// Toggle
    @State private var isCoder: Bool = true
    /// TextField
    @State private var textContent: String = ""
    @State private var password: String = ""
    /// Custom
    @State private var state: TripleState = .med
    
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
            
            /// Custom
            TripleToggle(tripleState: $state, label: Text("TripleToggle"))
                .tripleToggleStyle(KnobTripleToggleStyle(dotColor: .red))
        }
        .navigationTitle("Style & View Modifier")
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
