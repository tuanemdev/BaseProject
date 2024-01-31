//
//  HomeDataStore.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 31/01/2024.
//

import Foundation
import Observation

/**
 Model: chứa data và business logic
 model này có thể là:
     + của 1 view (TH này thì dùng View-only còn tách ra như này khá là giống ViewModel)
     + chia sẻ giữa các view (truyền data giữa các view như bình thường hoặc sử dụng @Bindale)
     + chia sẻ trong hệ thống phân cấp view bằng các đưa vào Environment
 */
@Observable
final class HomeDataStore {
    /// Khai báo data
    var productName: String = "Apple Vision Pro"
    var price: Int = 3499
    
    @ObservationIgnored
    private var issue: String = ""
    
    /// Triển khai logic
    func showAmazingJob() {
        price += 1
    }
    
    private func resolveIssue() {
        issue = ""
    }
}

/**
 Target nói chung để SwiftUI có thể gọi là sẵn sàng cho Product (tương đối phức tạp) theo quan điểm cá nhân là từ iOS 16
 Ban đầu tính triển khai với  ObservableObject nhưng nghĩ lại Observable mới, cải tiến và hay hơn nên sử dụng
 Mặc dù viết với Observation nhưng do base này là viết cho iOS 16 nên khi muốn sử dụng được cho iOS 16 chỉ cần thay thế
 bằng ObservableObject là được, các triển khai hoàn toàn tương tự nhau.
 
 Link tham khảo:
 + https://developer.apple.com/documentation/observation
 + https://developer.apple.com/videos/play/wwdc2023/10149/
 */
