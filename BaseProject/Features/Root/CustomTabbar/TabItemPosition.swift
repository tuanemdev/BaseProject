//
//  TabItemPosition.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 28/01/2024.
//

import SwiftUI

struct PositionKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension View {
    @ViewBuilder
    func viewPosition(completion: @escaping (CGRect) -> Void) -> some View {
        overlay {
            GeometryReader { proxy in
                let rect = proxy.frame(in: .global)
                
                Color.clear
                    .preference(key: PositionKey.self,value: rect)
                    .onPreferenceChange(PositionKey.self, perform: completion)
            }
        }
    }
}
