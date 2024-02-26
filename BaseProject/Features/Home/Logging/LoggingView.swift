//
//  LoggingView.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 07/02/2024.
//

import SwiftUI
import OSLog

/// https://developer.apple.com/documentation/os/logger
struct LoggingView: View {
    @Binding var isPresented: Bool
    /**
     Khởi tạo logger cần subsystem và category. Được sử dụng cho mục đích tìm kiếm về sau.
     - subsystem thì lời khuyên nên đặt chính là bundleID
     - category thì tùy mục đích, có thể đặt là tên Object như sau.
     
     Nên dùng Logger thay vì print bởi:
     + Cung cấp nhiều thông tin hơn (bổ sung metadata bên cạnh log message)
     + Có khả năng lấy log qua Console app mà không cần run trực tiếp với Xcode
     + Có khả năng lấy log trong một khoảng thời gian trong quá khứ do log được lưu trữ
     */
    private let logger: Logger = .init(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: Self.self)
    )
    
    private let someThingInfo: Float = 100.00
    /// LogStore
    @State private var entries: [String] = .init()
    private let logFileURL = URL.documentsDirectory.appending(path: "LogStore.txt", directoryHint: .isDirectory)
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Button("Test Log Function") {
                    logAction()
                }
                Button("Save to URL Document") {
                    save()
                }
                ShareLink(item: logFileURL) {
                    Text("Share Log File")
                }
                
                if entries.isEmpty {
                    ContentUnavailableView(
                        "No Logs",
                        systemImage: "list.bullet.rectangle.portrait",
                        description: Text("Try 'Test Log Function'and re-enter this View")
                    )
                } else {
                    Text(entries.joined(separator: "\n"))
                }
            }
            .buttonStyle(.baseStyle)
            .frame(maxWidth: .infinity)
        }
        .background(Color.baseBackground)
        .overlay(alignment: .topLeading) {
            Button {
                isPresented = false
            } label: {
                Image(systemName: "x.circle.fill")
                    .symbolRenderingMode(.hierarchical)
                    .font(.title2)
                    .padding(.leading, 15)
            }
        }
        .task {
            await export()
        }
    }
    
    private func logAction() {
        /**
         Debug log level
         
         debug và trace tương đương với nhau
         chỉ được lưu vào memory
         */
        logger.debug("debug funtion: \(someThingInfo, privacy: .public)")
        logger.trace("trace funtion: \(someThingInfo)")
        
        /**
         Default log level
         
         Default log level cùng cấp với Debug log level
         khác nhau ở chỗ Default log level được lưu vào cả memory và disk
         */
        logger.notice("notice funtion")
        
        /**
         Info log level
         
         chỉ được lưu vào memory (nếu sử dụng log command line tool thì cũng sẽ được lưu vào disk)
         */
        logger.info("info funtion")
        
        /**
         Error log level
         
         error và warning tương đương với nhau
         được lưu vào cả memory và disk
         */
        logger.error("error funtion")
        logger.warning("warning funtion")
        
        /**
         Fault log level
         
         fault và critical tương đương với nhau
         được lưu vào cả memory và disk
         */
        logger.fault("fault funtion")
        logger.critical("critical funtion")
        
        /**
         TÍNH BẢO MẬT
         Do thông tin log có thể nhạy cảm và để đảm bảo an toàn thì chỉ có StaticString là được hiển thị
         các thông tin khác sẽ hiển thị <private> theo mặc định
         (StaticString: chuỗi cố định không thay đổi, không có tham số trong chuỗi)
         Để hiển thị các thông tin như nội dung của someThingInfo phía trên ta cần cung cấp privacy level cho nó
         Ngoài ra thì có thể có một số lựa chọn định dạng khác cho nó trong message - chi tiết: OSLogInterpolation
         */
        logger.trace("trace funtion: \(someThingInfo, format: .fixed, align: .right(columns: 10), privacy: .private(mask: .hash))")
    }
    
    /// Lấy thông tin đã được lưu trong LogStore
    private func export() async {
        do {
            let store = try OSLogStore(scope: .currentProcessIdentifier)
            /// Lấy thông tin trong vòng 24h qua
            let date = Date.now.addingTimeInterval(-24 * 3600)
            let position = store.position(date: date)
            
            let entries = try store
                .getEntries(at: position)
                .compactMap { $0 as? OSLogEntryLog }
                .filter { $0.subsystem == Bundle.main.bundleIdentifier! }
                .map { "[\($0.date.formatted())] [\($0.category)] \($0.composedMessage)" }
            Task { @MainActor in
                self.entries = entries
            }
        } catch {
            logger.warning("\(error.localizedDescription, privacy: .public)")
        }
    }
    
    private func save() {
        do {
            try entries
                .joined(separator: "\n")
                .write(to: logFileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            logger.warning("\(error.localizedDescription, privacy: .public)")
        }
    }
}

#Preview {
    LoggingView(isPresented: .constant(true))
}
