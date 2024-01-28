//
//  NavigationBar.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 28/01/2024.
//

import SwiftUI

// MARK: - Extension
extension View {
    func navigationBar(_ config: @escaping (UINavigationController) -> Void) -> some View {
        modifier(NavigationBarViewModifier(config: config))
    }
}

// MARK: - ViewModifier
struct NavigationBarViewModifier: ViewModifier {
    let config: (UINavigationController) -> Void
    
    func body(content: Content) -> some View {
        content.background(NavigationBarConfig(config: config))
    }
}

// MARK: - Background UIViewControllerRepresentable
struct NavigationBarConfig: UIViewControllerRepresentable {
    let config: (UINavigationController) -> Void
    
    func makeUIViewController(context: Context) -> NavigationBarConfigViewController {
        NavigationBarConfigViewController(config: config)
    }
    
    func updateUIViewController(_ uiViewController: NavigationBarConfigViewController, context: Context) {
        //
    }
}

// MARK: - Background UIViewController
final class NavigationBarConfigViewController: UIViewController {
    let config: (UINavigationController) -> Void
    
    init(config: @escaping (UINavigationController) -> Void) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let navigationController {
            config(navigationController)
        }
    }
}
