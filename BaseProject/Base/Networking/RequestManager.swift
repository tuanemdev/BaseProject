//
//  RequestManager.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 24/12/2023.
//

import Foundation

protocol RequestManagerProtocol {
    func perform<T: Decodable>(_ request: APIRequest, allowRetry: Bool) async throws -> T
}

class RequestManager: RequestManagerProtocol {
    let apiManager: APIManagerProtocol
    let parser: DataParserProtocol
    let accessTokenManager: AccessTokenManagerProtocol
    
    init(
        apiManager: APIManagerProtocol = APIManager(),
        parser: DataParserProtocol = DataParser(),
        accessTokenManager: AccessTokenManagerProtocol = AccessTokenManager(requestManager: RequestTokenManager())
    ) {
        self.apiManager = apiManager
        self.parser = parser
        self.accessTokenManager = accessTokenManager
    }
    
    func perform<T: Decodable>(_ request: APIRequest, allowRetry: Bool = true) async throws -> T {
        let authToken = try await requestAccessToken()
        
        do {
            let data = try await apiManager.perform(request, authToken: authToken)
            let decoded: T = try parser.parse(data: data)
            return decoded
        } catch let error as AuthError { #warning("Sửa lại handle error")
            guard allowRetry else { throw error }
            return try await perform(request, allowRetry: false)
        } catch {
            throw error
        }
    }
    
    func requestAccessToken() async throws -> String {
        return try await accessTokenManager.validToken().bearerAccessToken
    }
}

class RequestTokenManager: RequestManagerProtocol {
    let apiManager: APIManagerProtocol
    let parser: DataParserProtocol
    
    init(
        apiManager: APIManagerProtocol = APIManager(),
        parser: DataParserProtocol = DataParser()
    ) {
        self.apiManager = apiManager
        self.parser = parser
    }
    
    func perform<T: Decodable>(_ request: APIRequest, allowRetry: Bool = false) async throws -> T {
        let data = try await apiManager.perform(request, authToken: "authToken")
        let decoded: T = try parser.parse(data: data)
        return decoded
    }
}
