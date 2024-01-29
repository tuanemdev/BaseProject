//
//  HomeView.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 28/01/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        List {
            NavigationLink(value: HomeDestination.resources) {
                Text("Resources Manager")
            }
            NavigationLink(value: HomeDestination.language) {
                Text("Language Manager")
            }
            NavigationLink(value: HomeDestination.modifier) {
                Text("View Modifier")
            }
        }
        .background(Color.baseBackground)
        .navigationTitle("Base Project")
    }
}
