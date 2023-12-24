//
//  APIToken.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 24/12/2023.
//

import Foundation

struct APIToken {
    let tokenType: String
    let accessToken: String
    let expiresIn: Int
    private let requestedAt = Date()
}

extension APIToken: Codable {
    enum CodingKeys: String, CodingKey {
        case tokenType
        case accessToken
        case expiresIn
    }
}

extension APIToken {
    var expiresAt: Date {
        Calendar.current.date(byAdding: .second, value: expiresIn, to: requestedAt) ?? Date()
    }
    
    var bearerAccessToken: String {
        "\(tokenType) \(accessToken)"
    }
}
