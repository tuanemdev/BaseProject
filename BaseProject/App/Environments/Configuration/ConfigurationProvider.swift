//
//  ConfigurationProvider.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 24/12/2023.
//

import Foundation

protocol EnvironmentConfig {
    var environment: AppEnvironment { get }
    var baseURL: String { get }
    var secretKey: String { get }
}

enum ConfigurationProvider: EnvironmentConfig {
    case `default`
    
    /// Tạo một enum để không hard-code
    /// Các key-value được khai báo trong file config cũng sẽ tự động xuất hiện tại: Project ➝ Targets ➝ Build Settings ➝ User-Defined (cuối cùng)
    /// Có thể thêm key-value trực tiếp bằng cách ấn button + (Add User-Defined Setting) (hàng trên cùng)
    /// Không cần thiết thêm vào Info.plist nếu không cần lấy giá trị khi code. Sử dụng trực tiếp trong Build Settings bằng cú pháp $(KEY)
    enum Keys {
        static let config       = "CONFIGURATION"
        static let baseURL      = "BASE_URL"
    }
    
    /// Tên của config đang sử dụng: Project ➝ Info ➝ Configurations
    var config: String {
        try! Configuration.value(for: Keys.config)
    }
    
    var environment: AppEnvironment {
        AppEnvironment(rawValue: config.lowercased())!
    }
    
    /// Key-Value custom được điền trong các file .xcconfig
    var baseURL: String {
        try! Configuration.value(for: Keys.baseURL)
    }
    
    /// Các thông tin trong file Info.plist có thể bị đánh cắp, do đó vì lý do bảo mật, các giá trị mang tính bảo mật không được lưu trong các file xcconfig
    /// Lưu trong code cũng có nguy cơ bị dịch ngược. Để an toàn thì cách tốt nhất là lưu trên server
    /// Trong trường hợp phải lưu ở client thì nên lưu dưới dạng đã được mã hóa.
    var secretKey: String {
        switch environment {
        case .development:  "APIKey_DEV_Encrypted"
        case .staging:      "APIKey_ST_Encrypted"
        case .production:   "APIKey_PR_Encrypted"
        }
    }
    
    // MARK: - Custom Flag
    /// Custom flags theo các bước: Project ➝ Build Settings ➝ Swift Complier ➝ Custom Flags
    /// Đặt tên theo cú pháp -DNAME
    /// Cách đặt tên ở đây chỉ là ví dụ, thường sẽ không đặt trùng với tên các config
    var customFlag: String {
        #if PRODUCTION
        "PRODUCTION FLAGS"
        #elseif DEVELOPMENT
        "DEVELOPMENT FLAGS"
        #else
        "STAGING FLAGS"
        #endif
    }
    
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
