//
//  APIRequestExample.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 24/12/2023.
//

import Foundation

// MARK: - Auth Request
enum AuthTokenRequest: APIRequest {
    case auth
    case refresh(token: String)
    
    var path: String { "/v2/oauth2/token" }
    
    var requestType: HTTPMethod { .POST }
    
    var addAuthorizationToken: Bool { false }
    
    var params: [String: Any] {[
        "grant_type": APIConstants.grantType,
        "client_id": APIConstants.clientId,
        "client_secret": APIConstants.clientSecret
    ]}
}

// MARK: - Normal Request
enum AnimalsRequest: APIRequest {
    case getAnimalsWith(page: Int, latitude: Double?, longitude: Double?)
    case getAnimalsBy(name: String, age: String?, type: String?)
    
    var path: String { "/v2/animals" }
    
    var urlParams: [String: String?] {
        switch self {
        case let .getAnimalsWith(page, latitude, longitude):
            var params = ["page": String(page)]
            if let latitude { params["latitude"] = String(latitude) }
            if let longitude { params["longitude"] = String(longitude) }
            params["sort"] = "random"
            return params
            
        case let .getAnimalsBy(name, age, type):
            var params: [String: String] = [:]
            if !name.isEmpty { params["name"] = name }
            if let age { params["age"] = age }
            if let type { params["type"] = type }
            return params
        }
    }
    
    var requestType: HTTPMethod { .GET }
}
