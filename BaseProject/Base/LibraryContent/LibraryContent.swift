//
//  LibraryContent.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 25/01/2024.
//

import SwiftUI

struct LibraryContent: LibraryContentProvider {
    /// Thêm vào item đầu tiên trong Library: Views
    var views: [LibraryItem] {
        @State var State: TripleState = .med
        LibraryItem(
            TripleToggle(tripleState: $State, label: Text("Placeholder")),
            category: .control
        )
        
        LibraryItem(
            FlowLayout { },
            category: .layout
        )
    }
    
    /// Thêm vào item thứ hai trong Library: Modifiers
    func modifiers(base: Text) -> [LibraryItem] {
        LibraryItem(
            base.padding(),
            category: .effect
        )
    }
}
