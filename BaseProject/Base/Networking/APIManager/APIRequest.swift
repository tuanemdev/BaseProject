//
//  APIRequest.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 24/12/2023.
//

import Foundation

protocol APIRequest {
    var path: String { get }
    var urlParams: [String: String?] { get }
    var requestType: HTTPMethod { get }
    var headers: [String: String] { get }
    var addAuthorizationToken: Bool { get }
    var params: [String: Any] { get }
}

extension APIRequest {
    var host: String { APIConstants.host }
    var urlParams: [String: String?] { [:] }
    var headers: [String: String] { [:] }
    var addAuthorizationToken: Bool { true }
    var params: [String: Any] { [:] }
    
    func createURLRequest(authToken: String) throws -> URLRequest {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        
        if !urlParams.isEmpty {
            components.queryItems = urlParams.map { URLQueryItem(name: $0, value: $1) }
        }
        
        guard let url = components.url
        else { throw NetworkError.invalidURL }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = requestType.rawValue
        
        if !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }
        if addAuthorizationToken {
            urlRequest.setValue(authToken, forHTTPHeaderField: "Authorization")
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if !params.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
        }
        
        return urlRequest
    }
}
