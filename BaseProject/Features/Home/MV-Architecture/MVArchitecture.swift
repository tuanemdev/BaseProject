//
//  MVArchitecture.swift
//  BaseProject
//
//  Created by AnhNT19 on 31/01/2024.
//

import SwiftUI

struct MVArchitecture: View {
    // MARK: - State (Data) hay Single source of truth
    /**
     Đây là cách chia sẻ data bằng cách đưa vào hệ thống phân cấp View
     nếu không có HomeDataStore nào được đưa vào environment thì SwiftUI sẽ ném ra một exception gây crash
     Nếu không chắc chắn và muốn return nil thay vì crash thì sử dụng cú pháp khai báo environment như sau:
     @Environment(HomeDataStore.self) private var homeDataStore: HomeDataStore?
     */
    @Environment(HomeDataStore.self) private var homeDataStore
    /**
     Nếu sử dụng cách truyền data giữa các View thì khai báo:
     var homeDataStore: HomeDataStore
     hoặc
     @Bindable  var homeDataStore: HomeDataStore
     */
    
    /// State khác, State thuộc về local View
    @State private var otherState: String = "Macbook Pro M3 MAX 16 inch"
    
    // MARK: - View trong SwiftUI là function of state
    /**
     Declarative programming: lập trình khai báo
     Đây không phải là UI, mà đây là hướng dẫn cách UI được vẽ trên màn hình dựa trên State. Do đó nó được gọi là function of state
     Vì quan điểm này mà có nhiều người không gọi đây là View theo cách hiểu của các mô hình truyền thống, mà nó giống như ViewModel trong các mô hình truyền thống hơn, hoạt động giống như việc Binding data lên UI
     
     View là function of state nhưng không nên thích viết View như thế nào thì viết.
     Hãy suy nghĩ về FP (Functional Programming), coi var body là function và trạng thái của các State là các tham số truyền vào
     cùng các tham số truyền vào thì kết quả khi return luôn phải giống nhau.
     
     Nhiều khi var body: some View trở nên quá cồng kềnh thì nên tách nhỏ nó ra
     bằng cách tạo 1 computed property, 1 function return some View hoặc 1 Struct View giống như các Component dùng chung khác
     
     Logic (ví dụ như action của Button) nếu đơn giản hoặc màn hình đơn giản có thể viết trực tiếp vào body View,
     nhưng nếu phức tạp hơn thì nên tách ra thành 1 function riêng xuống phía dưới hoặc nằm trong DataStore (như homeDataStore)
     State không nên thay đổi trực tiếp trong body View, không cần quá nguyên tắc nhưng hạn chế nhất là với các màn hình phức tạp
     do bản chất có 1 State luôn thay đổi trực tiếp trong body View đó là các State có thể Binding (ví dụ như dùng trong TextField)
     */
    var body: some View {
        /**
         Environment không Bindable theo mặc định, đây là cách để sử dụng Bindable với data được đưa vào trong environment
         còn nếu sử dụng ObservableObject thì biến trong environment có thể @Binding theo mặc định
         */
        @Bindable var homeDataStore = homeDataStore
        
        ScrollView(.vertical) {
            VStack {
                Text("Hello, MV Architecture!")
                Text("natural way to write your code")
                aPrivateComponent
                TextField("Share State", text: $homeDataStore.productName)
                TextField("Local State", text: $otherState)
            }
        }
        .background(.baseBackground)
        .navigationTitleView(title: "MV Architecture", subTitle: "code your way", icon: "shippingbox.fill")
    }
    
    @ViewBuilder /// Tìm hiểu về result builder để biết các nó hoạt động
    var aPrivateComponent: some View {
        Text("Xcode and friends")
    }
    
    // MARK: - Logic (View-only) hoặc các logic khác nằm ngoài HomeDataStore
    private func someLogicHere() {
        let target = "Buy \(homeDataStore.productName) & \(otherState)"
        print(target)
    }
}

#Preview {
    MVArchitecture()
        .environment(HomeDataStore())
}
