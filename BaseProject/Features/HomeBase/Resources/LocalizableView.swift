//
//  LocalizableView.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 08/01/2024.
//

import SwiftUI

struct LocalizableView: View {
    let aStringVariable: String = "Allways English"
    
    var body: some View {
        VStack {
            Text(LocalizedKey.greeting(personName: "Chi Pu"))
            Text(LocalizedKey.aboutMe)
            Text(LocalizedKey.introduce(platform: "rock", exp: 20))
            Divider()
            
            /// 2 cái dưới này khác 3 cái trên về bản chất.
            /// Nội dung trong Text (View) là String đã được localize chứ không phải là Key
            /// Như Note ở file LocalizedKey: Cái này là cách trước đây và cần sử dụng khi muốn support cho UIKit, bây giờ nên chuyển sang dùng cái mới
            Text(String.localizedStringWithFormat(LocalizedKey.singASong, "Đóa Hoa Hồng")) /// hoặc cú pháp String(format: _, arguments:)
            Text(LocalizedKey.audienceBooed)
            Divider()
            
            /// Component
            LocalizableComponentView(content: LocalizedKey.aboutMe)
            Divider()
            
            /// Nếu không muốn tạo file LocalizedKey thì có thể dùng trực tiếp
            /// - Ưu điểm:
            /// + Dễ dùng, đây cũng là cách mà Apple ví dụ và các View khác của Base này sử dụng (cho tiện =)))
            /// + Không cần quan tâm loại truyền vào là LocalizedStringKey hay LocalizedStringResource
            /// + Không cần tạo static func cho các parameter và sử dụng trực tiếp StringInterpolation
            /// - Nhược điểm:
            /// + Hard Code
            Text("\(1000) spectators are screaming")
            Divider()
            
            /// Các cũ pháp dưới đây sẽ không localized
            Text(aStringVariable)
            Text(verbatim: "Không có gì quý hơn độc lập, tự do") /// verbatim: Nguyên văn
        }
        .navigationTitle(LocalizedKey.localizedTutorialTitle)
    }
}

/// Đây là ví dụ về việc Localized đối với các View dạng Component
struct LocalizableComponentView: View {
    let content: LocalizedStringResource /// hoặc: LocalizedStringKey
    var body: some View {
        Text(content)
    }
}

#Preview {
    LocalizableView()
}
