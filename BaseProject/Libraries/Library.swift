//
//  Library.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 09/01/2024.
//

/**
 Framework là một điều tuyệt vời, bởi vì thế giới code là rất rộng lớn, không ai học hết được
 Việc sử dụng framework giúp:
 + code nhanh hơn (sử dụng code đã được đóng gói sẵn)
 + code gọn hơn (tất cả các code liên quan được đóng gói gọn gàng trong 1 framework)
 + code chạy ít lỗi hơn (được viết bởi những người tài giỏi hơn bạn, cộng đồng đóng góp giúp cải thiện từ hiệu suất đến việc test kỹ càng)
 
 ======
 
 Framework rất tốt nhưng tránh lạm dụng framework.
 Khi lựa chọn sử dụng thì 1 framework nên đáp ứng đủ tất cả các yếu tố sau:
 + Nhiều sao trên github (chứng minh độ phổ biến, và là minh chứng về một thư viện tốt)
 + Ít issues
 + Vẫn tiếp tục được update cải thiện (sửa lỗi liên tục, cập nhập theo các version swift mới nhất)
 
 ======
 
 Có nhiều cách sử dụng thư viện:
 - Tự động: (Trình quản lý gói)
    + SPM (Swift Package Manager) (SPM và phần còn lại, nên và chỉ nên sử dụng SPM)
    + CocoaPods: Có nhược điểm lớn làm cho 1 project cồng kềnh, phá vỡ cấu trúc hiện tại: tạo thêm file .xcworkspace, thư mục Pods, file Podfile và Podfile.lock thiếu trực quan,
               vấn đề tranh cãi liên quan đến việc có đưa Pods vào version control hay không,...
    + Carthage: ít được sử dụng nhất trong 3 phương pháp trên
 - Thủ công
    + Vứt file .xcframework vào đây hoặc cả folder chứa file source code của thư viện
 
 Hầu hết các thư viện hiện tại đều đã hỗ trợ SPM, tuy nhiên nếu bạn gặp 1 thư viện không hỗ trợ thì sao:
 - Thư viện đến từ đối tác: nhắn tin bắt nó hỗ trợ, việc code thư viện mới lâu chứ việc support thêm SPM thì nhanh
 - Thư viện trên github:
    + Dùng cách thủ công tải file framework họ cung cấp đưa vào dự án
    + Tải source thư viện về, tự build ra file .xcframework hoặc lọc ra những file source code cần thiết vứt vào dự án
 (Thư mục Libraries mục đích là để chứa các framework thủ công này, còn các framework khác sẽ được quản lý bởi SPM)
 */
