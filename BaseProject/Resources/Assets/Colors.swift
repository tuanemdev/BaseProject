//
//  Colors.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 09/01/2024.
//

import SwiftUI

/// File này sẽ không cần thiếu đối với dự án support > iOS 17 bởi vì Xcode 15 đã mang tới công cụ generation chính thức
/// với sự ra đời của: ImageResource và ColorResource
/// Link đọc tham khảo thêm: https://sarunw.com/posts/swift-symbols-for-asset-catalog/
/// Nội dung file này nói về Color, Image làm hoàn toàn tương tự

/// Vậy nếu với các dự án support dưới iOS 17 thì sao
/// Có 3 cách tiếp cận chính:

/// Cách 1: Sử dụng thư viện hỗ trợ generation
/// Nổi bật có thể kể đến: SwiftGen - https://github.com/SwiftGen/SwiftGen
/// Quan điểm cá nhân thì mình sẽ không dùng cách này (Đọc comment trong thư mục Libraries)
/// Thời điểm đang viết trên file này thì SwiftGen đã hơn 2 năm chưa cập nhật gì và có nhiều issues

/// 2 cách dưới là cách thủ công:

/// Cách 2: Sử dụng Enum
enum Colors {
    static let baseBackground = "base_background"
}

/// Cách 3: Sử dụng Extension
/// Ưu điểm của cách này là dễ sử dụng, đây cũng là cách mà Apple define các color của mình: Ví dụ: Color.red (Jump to Definition để hiểu)
/// Nhược điểm: Vậy khi muốn làm việc với UIColor, NSColor thì sao? Ta phải viết thêm cả extension cho các loại này, hoặc đi đường vòng tạo UIColor từ Color bằng func: convenience init(_ color: Color)
/// Ưu tiên sử dụng cách này nếu nhược điểm trên không phải là vấn đề hoặc có vấn đề nhưng cách đi đường vòng là chấp nhận được
extension Color {
    static let baseBackground1 = Color("base_background") /// Lý do có số 1 sau tên là do nó đã được khai báo tự động bởi Xcode (Hãy xoá thử để nhận thông báo lỗi)
}

// MARK: - Tại sao lại viết code như vậy?
/// Một chút bàn luận về việc tạo file chứa các nội dung là hằng số (let)
/// Không bao giờ sử dụng: static var stored property vì nó chẳng khác vì một biến global cả
struct StructConstant {
    static let strongestMan: String = "One Punch Man"
}

enum EnumConstant {
    static let beautifulGirl: String    = "Boa Hancock"
    static var iOSDevIDE: String        { "Xcode" }
}
/// Giữa Struct và Enum chọn cái nào?
/// ➦ Enum bởi vì ta sẽ không mắc lỗi khởi tạo một instance Constant vô nghĩa
///     ví dụ: let structConstant: StructConstant = .init()
///         let enumConstant: EnumConstant = ??? (Không thể khởi tạo được vì EnumConstant không chứa case nào)
///     Đây cũng là lý do không nên sử dụng Enum với Rawvalue làm file Constant
///
/// Giữa static computed property vs static let constant (như ví dụ trong EnumConstant)
/// ➦ Chọn 1 trong 2 tuỳ sở thích của bạn. Quan điểm cá nhân thích static let constant hơn vì nhìn cú pháp thuận mắt hơn
/// 2 cách này hoàn toàn giống nhau: https://forums.swift.org/t/static-computed-property-vs-static-let-constant/20968
/// (Lưu ý: computed property ở đây là computed property đơn giản như ví dụ phía trên, nếu nó phức tạp hơn thì phải tuân thủ theo nguyên tắc của functional programming)
