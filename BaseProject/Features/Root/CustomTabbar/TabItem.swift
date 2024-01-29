//
//  TabItem.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 28/01/2024.
//

import Foundation

enum TabItem: String, CaseIterable {
    case home       = "Home"
    case services   = "Services"
    case partners   = "Partners"
    case activity   = "Activity"
    
    var systemImage: String {
        switch self {
        case .home:
            return "house"
        case .services:
            return "envelope.open.badge.clock"
        case .partners:
            return "hand.raised"
        case .activity:
            return "bell"
        }
    }
    
    var index: Int {
        return TabItem.allCases.firstIndex(of: self) ?? 0
    }
}
