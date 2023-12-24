//
//  AccessTokenManager.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 24/12/2023.
//

import Foundation

protocol AccessTokenManagerProtocol: Actor {
    var requestManager: RequestManagerProtocol { get set }
    func validToken() async throws -> APIToken
    func refreshToken() async throws -> APIToken
}

enum AppUserDefaultsKeys {
    static let bearerAccessToken = "bearerAccessToken"
    static let expiresAt = "expiresAt"
}

actor AccessTokenManager: AccessTokenManagerProtocol {
    var requestManager: RequestManagerProtocol
    init(requestManager: RequestManagerProtocol) {
        self.requestManager = requestManager
    }
    
    private var currentToken: APIToken?
    private var refreshTask: Task<APIToken, Error>?
    private var expiresAt = Date()
    
    func validToken() async throws -> APIToken {
        if let handle = refreshTask {
            return try await handle.value
        }
        
        guard let token = currentToken else {
            throw AuthError.missingToken
        }
        
        if expiresAt.compare(Date()) == .orderedDescending {
            return token
        }
        
        return try await refreshToken()
    }
    
    func refreshToken() async throws -> APIToken {
        if let refreshTask = refreshTask {
            return try await refreshTask.value
        }
        let task = Task { () throws -> APIToken in
            defer { refreshTask = nil }
            
            let newToken: APIToken = try await requestManager.perform(AuthTokenRequest.refresh(token: "refreshToken"), allowRetry: false)
            currentToken = newToken
            
            return newToken
        }
        
        self.refreshTask = task
        
        return try await task.value
    }
    
    func isTokenValid() -> Bool {
        return currentToken != nil
    }
}

enum AuthError: Error {
    case missingToken
}
