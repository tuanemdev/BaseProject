//
//  HomeBaseView.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 28/01/2024.
//

import SwiftUI

struct HomeBaseView: View {
    var body: some View {
        List {
            NavigationLink(value: "Resource") {
                Text("Resources Manager")
            }
            NavigationLink(value: "Localizable") {
                Text("Language Manager")
            }
            NavigationLink(value: "Modifier") {
                Text("View Modifier")
            }
        }
        .navigationDestination(for: String.self) { string in
            switch string {
            case "Resource":
                ResourcesView()
            case "Localizable":
                LocalizableView()
            default:
                StyleView()
            }
        }
        .navigationTitle("Base Project")
    }
}
