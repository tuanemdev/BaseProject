//
//  ContentView.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 24/12/2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color(.baseBackground)
                .ignoresSafeArea()
            
            VStack {
                Text("Base SwiftUI Project")
                    .foregroundStyle(Color.baseTitle)
                
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
}
