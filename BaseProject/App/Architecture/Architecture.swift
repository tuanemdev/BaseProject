//
//  Architecture.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 22/01/2024.
//

/**
 Design Pattern nói chung và App Architecture (Structural Design Pattern) nói riêng sinh ra để giải quyết một số vấn đề nhất định.
 Vậy nên sẽ không có Architecture nào là base chung cho tất cả các dự án, tùy thuộc vào yêu cầu của mỗi dự án mà lựa chọn Architecture phù hợp.
 (phù hợp với dự án và những con người đang làm trong dự án đó)
 
 Mỗi Architecture sẽ cố gắng giải quyết 1 nhóm vấn đề có liên quan đến nhau, nhưng nói chung đều cố gắng để đạt được các mục tiêu sau (1 vài ý có liên quan đến các nguyên tắc trong SOLID):
 + readable và maintainable
    code dễ đọc, có thể dễ dàng mở rộng và sửa đổi. Code đơn giản (không đồng nghĩa với nghĩ gì thì code đó) không nên viết những dòng code siêu phàm
 + tách biệt các nghiệp vụ không liên quan đến nhau để các team làm việc cùng 1 dự án nhưng làm trên các thành phần khác nhau, tránh conflict
 + trong cùng 1 nghiệp vụ thì lại tách ra thành các thành phần nhỏ hơn đảm nhận 1 vai trò nhất định (tránh tạo massive)
 + tạo ra các base chung tái sử dụng trong cùng dự án hoặc thậm chí giữa các dự án để tránh lặp code, tái sử dụng và dễ sửa đổi
 + testable (viết Unit Test)
 
 Architecture không phải những mô hình bị giới hạn sẵn có, mà chỉ là có những mô hình nổi bật và được cộng đồng đánh giá cao, sử dụng phổ biến thành những nguyên tắc chung.
 Do đó miễn là giải quyết được vấn đề trong dự án của bạn, bạn có thể tự tạo riêng cho dự án đó một mô hình riêng và đặt cho nó 1 cái tên mỹ miều gì đó =))

 SwiftUI là framework được ra đời dựa trên xu hướng chung của declarative programming (lập trình khai báo) và quản lý single source of truth bằng State
 Do tính chất khác với imperative programming nên tư tưởng về Architecture cũng thay đổi, bây giờ người ta quan tâm đến việc quản lý State nhiều hơn
 Khi làm việc với SwiftUI thì cho dù làm việc với mô hình nào cũng nên tuân thủ nguyên tắc mà nó được tạo thành:
 - POP: Protocol Oriented Programming (lập trình hướng chức năng) -  có thể thấy rõ nhất là View protocol của SwiftUI sử dụng cho struct
 - FP: Functional Programming (lập trình hàm) - mỗi 1 hàm View Modifier trong SwiftUI đều là FP
 
 Có 3 mô hình phổ biến trong SwiftUI
 
 1. MV (Model View) hoặc (View-only)
 Các màn hình đơn giản hoặc không chia sẻ State sẽ code trên View-only, còn khi muốn chia sẻ cụm State sẽ tạo một class Model chứa các State có thể Observable bằng ObservableObject hoặc Observation macro
 View-only: trên file view chia code rõ ràng thành 3 cụm: State + f(State) + Logic
 Model View: chia thành 2 file, 1 file f(State) + 1 chút Logic, 1 file class Model chứa các State + Logic chính cần chia sẻ (lý do nó là class vì được truyền đi nhưng vẫn cần giữ tham chiếu đến 1 instance)
 Cũng có thể coi đây là mô hình không View (theo nghĩa UI), còn View là ViewModel. Bởi var body: some View về cơ bản nó không phải là UI, mà chỉ là f(State) -> UI (View là function của State)
 __________
 + Ưu điểm:
    ~ dễ thực hiện, dễ hiểu, ai biết code SwiftUI đều có thể hiểu và làm theo được
    ~ là cách mà Apple viết mã mô tả và code ví dụ
 + Nhược điểm:
    ~ code không khéo dễ tạo massive và phân chia code không rõ ràng
    ~ không thể viết test
 
 
 2. MVVM (Đại diện cho mô hình 3 lớp Model - Presenter - View và các biến thể: MVC, MVP, MVVM-C, VIPER, ...)
 MVVM trong SwiftUI hay iOS nói chung là một trong các mô hình 3 lớp, đồng thời nó cũng không phải mô hình MVVM chuẩn trên lý thuyết mà được biến tấu đi cho dễ sử dụng và phù hợp với nền tảng.
 Mô hình MVVM chuẩn:
    ~ Model: chứa data và business logic. Model giống nhau trong mọi mô hình 3 lớp.
    ~ View: UI và mỗi một View cần 1 ViewModel của riêng nó
    ~ ViewModel: layer giữa View và Model, đảm nhận vai trò binding data lên UI và thông báo cho Model cập nhật data dựa trên action từ View + logic format data
 Mô hình MVVM iOS đang sử dụng:
    ~ Model: dễ dàng coi Data Object là model
    ~ View: UI và 1 View có thể không có ViewModel của riêng nó mà dùng chung với View khác
    ~ ViewModel: làm mọi việc từ lưu trữ data, xử lý business logic, binding, ....
 __________
 + Ưu điểm:
    ~ là một mô hình hài hòa giữa tính dễ triển khai và tính clean code
    ~ tách logic sang cho ViewModel, như vậy View sẽ không bị phình to
 + Nhược điểm:
    ~ dường như khó triển khai với SwiftUI, nhất là khi làn việc với share data và mỗi View có một ViewModel riêng để tách phần logic khỏi UI
    ~ khi triển khai đôi khi còn khó hiểu và tạo ra các code không cần thiết
    ~ ảnh hưởng tới hiệu năng khi sử dụng ObservableObject bởi vì nó sẽ render lại cả các View không dùng đến các State mà nó không dùng đến (đã được fix với Observation macro)
 
 
 3. TCA (Dựa trên Redux - Flux + Elm)
 Là một mô hình mới với iOS. Bởi vì nó được sinh ra để phù hợp với declarative programming
 Có thể chia làm 2 phần chính: View + Store (store lại chứa: State, Action, Reducer, Effect, quản lý Dependency Injection)
 Để viết về nó thì rất dài nên có thể đọc tham khảo các link sau:
 + Github: https://github.com/pointfreeco/swift-composable-architecture
 + Document: https://pointfreeco.github.io/swift-composable-architecture/main/tutorials/meetcomposablearchitecture/
 + Homepage: https://www.pointfree.co/collections/composable-architecture
 __________
 + Ưu điểm:
 Có thể nói chỉ quan tâm về mặt học thuật thì đây gần như là một mô hình hoàn hảo nhất từ trước đến nay mà iOS từng có
    ~ là một mô hình data flow 1 chiều (flow diagram giữa các thành phần sử dụng mũi tên 1 chiều)
    ~ quản lý state và action một cách rõ ràng, View chỉ biết về các State mà nó cần và các State chỉ có thể thay đổi thông qua Action
    ~ quản lý tốt side effect
    ~ quản lý tốt dependency
    ~ một công cụ test tuyệt vời
 + Nhược điểm:
    ~ quá hàn lâm về mặt học thuật
    ~ một mô hình có thể nói là khó nhất để hiểu bản chất thực sự của nó và cái đích mà nó nhắm tới, để sử dụng được cũng cần sự nỗ lực và thời gian tìm hiểu không hề nhỏ
    ~ cần phải sử dụng thư viện giống như một SPM bình thường, và các công cụ mà nó cung cấp không giống với Apple cung cấp cho chúng ta.
    nói chung Architecture không nên phụ thuộc vào một thư viện bên ngoài, không được Apple support chính thức. Architecture chỉ nên là cách triển khai code dựa trên các công cụ chính thống.
 
 
 Link tham khảo thêm:
 - Design Pattern và Refactor code: https://refactoring.guru/design-patterns
 - Mô hình 3 lớp: https://www.youtube.com/watch?v=I5c7fBgvkNY
 - Về MV và MVVM với SwiftUI:
    + https://azamsharp.com/2023/02/28/building-large-scale-apps-swiftui.html
    + https://forums.developer.apple.com/forums/thread/699003
 
 Note: các phần trong code demo này đều không tuân theo một Architecture nào cả, chỉ là những View để chứa các ví dụ cho các thành phần Base trong dự án.
 (View là không hoàn thiện và không tuân theo architecture do chỉ để làm ví dụ, còn các Base khác đều là hoàn thiện, nếu còn chưa tốt sẽ được đánh dấu #warning)
 */
