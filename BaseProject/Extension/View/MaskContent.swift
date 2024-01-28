//
//  MaskContent.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 28/01/2024.
//

import SwiftUI

extension View {
    func maskContent<Content: View>(_ using: Content) -> some View {
        self.overlay { using.mask(self) }
    }
}
