//
//  NetworkError.swift
//  BaseProject
//
//  Created by Nguyen Tuan Anh on 24/12/2023.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidServerResponse
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:               "URL string is malformed."
        case .invalidServerResponse:    "The server returned an invalid response."
        }
    }
}
