//
//  MinMaxSize.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 28/01/2024.
//

import SwiftUI

extension GeometryProxy {
    var minSize: Double {
        min(size.width, size.height)
    }
    
    var maxSize: Double {
        max(size.width, size.height)
    }
}
