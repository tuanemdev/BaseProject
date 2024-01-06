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
                    Text("Resource Manager")
                }
            }
            .navigationDestination(for: String.self) { string in
                ResourcesView()
            }
            .navigationTitle("Base Project")
        }
    }
}

#Preview {
    HomeView()
}
