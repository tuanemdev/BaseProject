//
//  TabItemView.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 28/01/2024.
//

import SwiftUI

struct TabItemView: View {
    var activeTint: Color
    var inactiveTint: Color
    var tabItem: TabItem
    var animation: Namespace.ID
    @Binding var activeTabItem: TabItem
    @Binding var position: CGPoint
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: tabItem.systemImage)
                .font(.title2)
                .foregroundColor(tabItem == activeTabItem ? .white : inactiveTint)
                .frame(width: tabItem == activeTabItem ? 58 : 35, height: tabItem == activeTabItem ? 58 : 35)
                .background {
                    if tabItem == activeTabItem {
                        Circle()
                            .fill(activeTint.gradient)
                            .matchedGeometryEffect(id: "ACTIVETABITEM", in: animation)
                    }
                }
            
            Text(tabItem.rawValue)
                .font(.caption)
                .foregroundColor(tabItem == activeTabItem ? activeTint : .gray)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .viewPosition { rect in
            if tabItem == activeTabItem {
                position.x = rect.midX
            }
        }
        .onTapGesture {
            activeTabItem = tabItem
        }
    }
}
