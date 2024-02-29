//
//  ConfigurationProvider.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 24/12/2023.
//

import Foundation

enum ConfigurationProvider {
    
    /// Tạo một enum để không hard-code
    /// Các custom key-value được khai báo trong file config cũng sẽ tự động xuất hiện tại: Project ➝ Targets ➝ Build Settings ➝ User-Defined (cuối cùng)
    /// Có thể thêm key-value trực tiếp bằng cách ấn button + (Add User-Defined Setting) (hàng trên cùng)
    /// Tham khảo danh sách Build Settings Key: https://developer.apple.com/documentation/xcode/build-settings-reference
    private enum Keys {
        static let config       = "CONFIGURATION"
        static let baseURL      = "BASE_URL"
    }
    
    /// Tên của config đang sử dụng: Project ➝ Info ➝ Configurations
    static var config: String {
        try! InfoPlistConfig.value(for: Keys.config)
    }
    
    static var environment: AppEnvironment {
        AppEnvironment(rawValue: config.lowercased())!
    }
    
    /// Key-Value được điền trong các file .xcconfig
    static var baseURL: String {
        try! InfoPlistConfig.value(for: Keys.baseURL)
    }
    
    /// Các thông tin trong file Info.plist (hay các file được đóng gói trong app bundle nói chung) có thể bị đánh cắp,
    /// do đó vì lý do bảo mật, các giá trị mang tính bảo mật không được lưu trong các file xcconfig
    /// Lưu trong code cũng có nguy cơ bị dịch ngược. Để an toàn thì cách tốt nhất là lưu trên server
    /// Trong trường hợp phải lưu ở client thì nên lưu dưới dạng đã được mã hóa trong Keychain sau khi tải về từ On-Demand Resource.
    static var secretKey: String {
        switch environment {
        case .development:  "APIKey_DEV_Encrypted"
        case .staging:      "APIKey_ST_Encrypted"
        case .production:   "APIKey_PR_Encrypted"
        }
    }
    
    // MARK: - Custom Flag
    /// Custom flags bằng key: OTHER_SWIFT_FLAGS
    /// Đặt tên theo cú pháp -DNAME
    /// Cách đặt tên ở đây chỉ là ví dụ, thường sẽ không đặt trùng với tên các config
    var customFlag: String {
        #if PROD
        "PRODUCTION FLAGS"
        #elseif DEV
        "DEVELOPMENT FLAGS"
        #else
        "STAGING FLAGS"
        #endif
    }
    
    // MARK: - Bundle ID
    /// Mỗi một môi trường nên có 1 BundleID để quản lý như 1 App riêng rẽ
    /// Mục đích để có thể build được cùng lúc các môi trường khác nhau trên device test
    /// vả quản lý các môi trường riêng rẽ trên Firebase để có thông tin log chính xác.
    
    // MARK: - Setup Scheme
    /// Để cho thuận tiện thì người ta thường tạo ra nhiều Scheme để thiết lập sẵn với các file config vừa tạo.
    /// Nếu không muốn tạo nhiều Scheme thì khi muốn thay đổi môi trường cần vào Edit Scheme để thay đổi trước khi build.
    
    // MARK: - Thiết lập Firebase với file GoogleService-Info.plist
    /// Việc sử dụng Firebase là rất thường xuyên, để chọn GoogleService-Info.plist cho đúng với config build.
    /// Điền path của GoogleService trong file config, lưu trong Info.plist và setup lệnh Build Phase Script như sau:
    /**
     GOOGLE_SERVICE_INFO_PLIST_SOURCE=${PROJECT_DIR}/${TARGET_NAME}/${GOOGLE_SERVICE_INFO_PLIST}

     if [ ! -f $GOOGLE_SERVICE_INFO_PLIST_SOURCE ]
     then
         echo "${GOOGLE_SERVICE_INFO_PLIST_SOURCE} not found."
         exit 1
     fi

     GOOGLE_SERVICE_INFO_PLIST_DESTINATION="${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist"

     cp "${GOOGLE_SERVICE_INFO_PLIST_SOURCE}" "${GOOGLE_SERVICE_INFO_PLIST_DESTINATION}"
     */
    
    /// Nếu run báo lỗi cần set ENABLE_USER_SCRIPT_SANDBOXING = No
    
    /*
     Hoặc sử dụng cách chính thống được giới thiệu trong tài liệu của Firebase, nhưng cách này sẽ ảnh hưởng đến Analytics
     do Analytics chỉ hoạt động tốt với file được đặt tên là GoogleService-Info.plist --> Ưu tiên sử dụng cách bên trên
     https://firebase.google.com/docs/projects/multiprojects
     let filePath = Bundle.main.path(forResource: "MyGoogleService", ofType: "plist")
     guard let fileopts = FirebaseOptions(contentsOfFile: filePath!)
     else { assert(false, "Couldn't load config file") }
     FirebaseApp.configure(options: fileopts)
     */
}
