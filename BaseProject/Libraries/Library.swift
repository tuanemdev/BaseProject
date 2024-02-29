//
//  Library.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 09/01/2024.
//

// MARK: - Đôi điều về thư viện
/**
 Framework là một điều tuyệt vời, bởi vì thế giới code là rất rộng lớn, không ai học hết được
 Việc sử dụng framework giúp:
 + code nhanh hơn (sử dụng code đã được đóng gói sẵn)
 + code gọn hơn (tất cả các code liên quan được đóng gói gọn gàng trong 1 framework) (Đây cũng là cách để module hóa project của bạn, giúp tách biệt các thành phần trong dự án)
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
    + Tải source thư viện về, lọc ra những file source code cần thiết vứt vào dự án
 (Thư mục Libraries mục đích là để chứa các binary framework hoặc nhặt file framework =)) này, còn các framework khác sẽ được quản lý bởi SPM)
 (mặc dù binary framework có thể được phân phối qua SPM nhưng nhiều khả năng đi làm thực tế thì đối tác sẽ gửi trực tiếp file .xcframework cho bạn)
 */

// MARK: - Sử dụng SPM
/**
 Những ngày đầu tiên giới thiệu (2019) thì SPM là một công cụ mới để quản lý thư viện (hay phần phụ thuộc) và được hỗ trợ một cách chính thống từ Apple
 SPM có một tuổi thơ cơ cực mà lý do lớn nhất là các thư viện phổ biến nhất tại thời điểm đó chưa hỗ trợ, thứ hai là các developer chưa quen sử dụng.
 Nhưng tại thời điểm hiện tại thì việc lựa chọn SPM làm trình quản lý phụ thuộc gần như là lựa chọn duy nhất bởi ưu điểm vượt trội mà nó đem lại
 Cùng điểm qua và so sánh với CocoaPods:
 + Ở thời điểm hiện tại, các thư viện phổ biến trước đây chưa hỗ trợ thì bây giờ đều đã hỗ trợ SPM, thậm chí các thư viện mới chỉ hỗ trợ quản lý thông qua SPM
   (TH phổ biến hay gặp mà vẫn phải dùng CocoaPods đó là các thư viện dạng business chỉ phục vụ mục đích để xây dựng app cho 1 vài công ty nào đó, trước đây được tích hợp bằng CocoaPods,
   hiện tại vì lý do kinh phí và bảo thủ nên chưa chuyển đổi sang cái mới)
 + Hàng chính thống từ Apple
 + Có thể phân phối cả source form (có thể đọc và biết hết code trong thư viện) và binary form (đóng vai trò như 1 box bao bọc .xcframework thay vì dùng trực tiếp)
 + Không làm thay đổi cấu trúc dự án (🚫 workspace, 🚫 folder Pod, 🚫 Podfile, 🚫 Podfile.lock)
 + Tự động hóa mọi thao tác và không cần sử dụng đến bất kỳ 1 câu lệnh nào cả (🚫 sudo gem install cocoapods, 🚫 pod init, 🚫 pod install, 🚫 pod update)
 + Không có rắc rối trong trường hợp 1 thư viện ở mỗi branch lại sử dụng 1 version khác nhau (hãy nghĩ về folder Pods khi không được đưa vào version control - git trong trường hợp này)
 
 
 Cơ chế và cách dùng
 - Thêm Package:
 + Click chuột phải vào vùng Project navigator (hệ thống thư mục của project) ➝ Add Package ...
 + Các package được thêm sẽ được hiển thị và quản lý trực quan tại Project ➝ Package Dependencies
 + Được cache tại DerivedData ➝ AppName-... ➝ SourcePackages (do đó khi clean DerivedData thì sẽ cần resolve lại package)
 + Phiên bản hiện tại đang được sử dụng hiển thị trực quan ngay bên cạnh tên package, hoặc biểu thị rõ ràng trong AppName.xcodeproj ➝ project.xcworkspace ➝ xcshareddata ➝ swiftpm ➝ Package.resolved
   (đóng vai trò như Podfile.lock để đảm bảo mọi người trong dự án đều sử dụng cùng một version của thư viện)
 
 - Cập nhật Package:
 + Project navigator ➝ Package Dependencies ➝ chuột phải ➝ ... HOẶC File ➝ Packages ➝ ...
 
 - Thêm/Xóa Package:
 Project ➝ Package Dependencies ➝ +/−
 */
