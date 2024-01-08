//
//  ContentView.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 24/12/2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(value: "Resource") {
                    Text("Resources Manager")
                }
                NavigationLink(value: "Localizable") {
                    Text("Language Manager")
                }
            }
            .navigationDestination(for: String.self) { string in
                switch string {
                case "Resource":
                    ResourcesView()
                default:
                    LocalizableView()
                }
            }
            .navigationTitle("Base Project")
        }
    }
}

#Preview {
    HomeView()
}
