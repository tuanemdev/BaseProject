//
//  ResourcesView.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 06/01/2024.
//

import SwiftUI

struct ResourcesView: View {
    @State private var pet: Pet? = nil
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                /// Color Set
                Text("Programming Languages")
                    .foregroundStyle(Color.baseTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                /// Image Set
                /// Sử dụng Folder với Namespace để có thể đặt tên các ảnh có cùng tên
                Image(.Swift.logo) /// Image("Swift/logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                
                Image(.Rust.logo)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(Color.baseTitle)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                
                /// Symbol Image Set
                /// Custom SF Symbol tuân thủ theo font
                /// Do đó đây là cách tuyệt vời để đặt Image cạnh Text
                (Text("Custom SF Symbol: ")
                 + Text(Image(.fanSealFill))
                 + Text(" fan"))
                .font(.system(size: 22, weight: .bold))
                
                if let pet = pet {
                    AsyncImage(url: pet.photo) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 40))
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color.baseBackground)
        .navigationTitle("Resources Manager")
        .onAppear {
            getPet()
        }
    }
    
    /// Data Set
    private func getPet() {
        guard let asset = NSDataAsset(name: "pet") else {
            fatalError("Missing data asset: pet")
        }
        let data = asset.data
        pet = try! JSONDecoder().decode(Pet.self, from: data)
    }
}

#Preview {
    ResourcesView()
}
