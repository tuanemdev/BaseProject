//
//  LocalizedKey.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 08/01/2024.
//

import SwiftUI

/// String Catalog có thể sử dụng ở mọi dự án không phân biệt version hỗ trợ tối thiểu là bao nhiêu
/// Bởi vì behind the scenes nó sẽ được convert ngược về Strings File và Stringsdict File khi build App (Đã được đánh dấu là Legacy - Di sản cần được bảo tổn nhưng không nên sử dụng nữa)
/// Đối với dự án cũ đang dùng Strings File thì cũng có thể dễ dàng Migrate bằng cách ấn chuột phải vào file này chọn Migrate to String Catalog...
/// và bật Use Compiler to Extract Swift Strings trong Build Settings - Localization (Đối với dự án mới tạo bằng Xcode 15 trở lên mặc định hỗ trợ)
/// Link phim: https://developer.apple.com/videos/play/wwdc2023/10155/
enum LocalizedKey {
    /// iOS 13
    /// Thuộc về SwiftUI
    static let localizedTutorialTitle: LocalizedStringKey                           = "Discover String Catalogs"
    static func greeting(personName: String) -> LocalizedStringKey                  { "Hello, I'm \(personName)!!!" }
    /// iOS 16
    /// Thuộc về Foundation
    static let aboutMe: LocalizedStringResource                                     = "About me"
    static func introduce(platform: String, exp: Int) -> LocalizedStringResource    { "I am an \(platform) singer with \(exp) years of experience" }
    
    /// Không khuyến khích sử dụng
    static let singASong: String                                                    = .init(localized: "Sing A Song", defaultValue: "A Song I'd Like To Sing %@", table: nil, bundle: nil, locale: .current, comment: "Favorite song")
    static let audienceBooed: String                                                = NSLocalizedString("Audience Booed", value: "Shut up bastard", comment: "")
}
