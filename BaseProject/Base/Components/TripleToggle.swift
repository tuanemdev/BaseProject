//
//  TripleToggle.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 25/01/2024.
//

// href: https://gist.github.com/swiftui-lab/4469338fd099285aed2d1fd00f5da745

import SwiftUI

// MARK: - TripleToggle View
struct TripleToggle: View {
    @Binding private var tripleState: TripleState
    private let label: Text
    
    init(tripleState: Binding<TripleState>, label: Text) {
        self._tripleState = tripleState
        self.label = label
    }
    
    @Environment(\.tripleToggleStyle) private var style: AnyTripleToggleStyle
    
    var body: some View {
        let configuration = TripleToggleStyleConfiguration(tripleState: self._tripleState, label: label)
        return style.makeBody(configuration: configuration)
    }
}

// MARK: - Custom Environment Key
extension EnvironmentValues {
    var tripleToggleStyle: AnyTripleToggleStyle {
        get {
            self[TripleToggleKey.self]
        }
        set {
            self[TripleToggleKey.self] = newValue
        }
    }
}

struct TripleToggleKey: EnvironmentKey {
    static let defaultValue: AnyTripleToggleStyle = AnyTripleToggleStyle(DefaultTripleToggleStyle())
}

// MARK: - View Extension
extension View {
    func tripleToggleStyle<S>(_ style: S) -> some View where S : TripleToggleStyle {
        environment(\.tripleToggleStyle, AnyTripleToggleStyle(style))
    }
}

// MARK: - Type Erased TripleToggleStyle
struct AnyTripleToggleStyle: TripleToggleStyle {
    private let style: any TripleToggleStyle
    
    init(_ style: any TripleToggleStyle) {
        self.style = style
    }
    
    func makeBody(configuration: Configuration) -> some View {
        AnyView(style.makeBody(configuration: configuration))
    }
}

// MARK: - TripleToggleStyle Protocol
protocol TripleToggleStyle {
    associatedtype Body : View
    
    func makeBody(configuration: Self.Configuration) -> Self.Body
    
    typealias Configuration = TripleToggleStyleConfiguration
}

struct TripleToggleStyleConfiguration {
    @Binding var tripleState: TripleState
    let label: Text
}

// MARK: - TripleState
enum TripleState {
    case low
    case med
    case high
}

// MARK: - Default TripleToggleStyle
struct DefaultTripleToggleStyle: TripleToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        DefaultTripleToggle(state: configuration.$tripleState, label: configuration.label)
    }
    
    struct DefaultTripleToggle: View {
        let width: CGFloat = 50

        @Binding var state: TripleState
        var label: Text
        
        var stateAlignment: Alignment {
            switch self.state {
            case .low: return .leading
            case .med: return .center
            case .high: return .trailing
            }
        }

        var stateColor: Color {
            switch self.state {
            case .low: return .green
            case .med: return .yellow
            case .high: return .red
            }
        }

        var body: some View {
            VStack(spacing: 10) {
                label
                
                ZStack(alignment: self.stateAlignment) {
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: self.width, height: self.width / 2)
                        .foregroundColor(self.stateColor)
                    
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: (self.width / 2) - 4, height: self.width / 2 - 6)
                        .padding(4)
                        .foregroundColor(.white)
                        .onTapGesture {
                            withAnimation {
                                switch self.state {
                                case .low:
                                    self.$state.wrappedValue = .med
                                case .med:
                                    self.$state.wrappedValue = .high
                                case .high:
                                    self.$state.wrappedValue = .low
                                }
                            }
                    }
                }
            }
        }
    }
}

// MARK: - Knob TripleToggleStyle
struct KnobTripleToggleStyle: TripleToggleStyle {
    let dotColor: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        KnobTripleToggle(dotColor: dotColor, state: configuration.$tripleState, label: configuration.label)
    }
    
    struct KnobTripleToggle: View {
        let dotColor: Color
        @Binding var state: TripleState
        var label: Text
        
        var angle: Angle {
            switch self.state {
            case .low: return Angle(degrees: -30)
            case .med: return Angle(degrees: 0)
            case .high: return Angle(degrees: 30)
            }
        }
        
        var body: some View {
            let g = Gradient(colors: [.white, .gray, .white, .gray, .white, .gray, .white])
            let knobGradient = AngularGradient(gradient: g, center: .center)
            
            return VStack(spacing: 10) {
                label
                
                ZStack {
                    Circle()
                        .fill(knobGradient)
                    
                    DotShape()
                        .fill(self.dotColor)
                        .rotationEffect(self.angle)
                }
                .frame(width: 150, height: 150)
                .onTapGesture {
                    withAnimation {
                        switch self.state {
                        case .low:
                            self.$state.wrappedValue = .med
                        case .med:
                            self.$state.wrappedValue = .high
                        case .high:
                            self.$state.wrappedValue = .low
                        }
                    }
                }
            }
        }
    }
    
    struct DotShape: Shape {
        func path(in rect: CGRect) -> Path {
            return Path(ellipseIn: CGRect(x: rect.width / 2 - 8, y: 8, width: 16, height: 16))
        }
    }
}
