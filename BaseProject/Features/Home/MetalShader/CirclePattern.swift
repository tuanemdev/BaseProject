//
//  CirclePattern.swift
//  NewScroll
//
//  Created by Astemir Eleev on 01.07.2023.
//

// href: https://github.com/eleev/swiftui-new-metal-shaders

import SwiftUI

struct CirclePattern: View {
    @State private var iterations: CGFloat = 20.0
    @State private var color: Color = .black
    @Environment(Router.self) private var router
    
    private let date = Date()
    
    var body: some View {
        List {
            TimelineView(.animation) {
                let time = date.timeIntervalSince1970 -  $0.date.timeIntervalSince1970
                
                Rectangle()
                    .aspectRatio(1, contentMode: .fit)
                    .colorEffect(
                        ShaderLibrary.circlePattern(
                            .boundingRect,
                            .float(time),
                            .color(color),
                            .float(iterations)
                        )
                    )
            }
            .clipShape(RoundedRectangle(cornerRadius: 24))
            
            Section("Iterations") {
                Slider(value: $iterations, in: 5...100)
            }
            
            Section("Color") {
                ColorPicker("Wave", selection: $color, supportsOpacity: false)
            }
            
            Section("Test Router") {
                Button("Back To Root") {
                    router.backToRoot()
                }
                
                Button("Change Tab") {
                    router.changeTab(to: .partners)
                }
            }
            
            Spacer().frame(height: 40)
                .listRowBackground(Color.clear)
        }
        .background(Color.baseBackground)
        .navigationTitle("Metal Shader")
    }
}

#Preview("Circle Pattern") {
    CirclePattern()
        .environment(Router.init())
}
