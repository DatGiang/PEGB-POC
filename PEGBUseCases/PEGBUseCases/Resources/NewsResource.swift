//
//  NewsResource.swift
//  PEGBUseCases
//
//  Created by Dat Giang on 25/02/2024.
//

import Foundation
import Networking

enum NewsResource {
    case topHeadlines
}

extension NewsResource: Requestable {
    var parameters: [String : Any]? {
        switch self {
        case .topHeadlines: return defaultParameters
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .topHeadlines: return nil
        }
    }
    
    var request: Networking.Request {
        switch self {
        case .topHeadlines:
            return .get(path: "/top-headlines")
        }
    }
    
    var url: String {
        "\(baseUrl)\(request.path)"
    }
    
    var token: String? { nil }
    
    var headers: [String : String]? { nil }
    
}

extension Requestable {
    var defaultParameters: [String: Any] {
        [
            "country": "us",
            "apiKey": "afcf73ca76ed4fe6a8b76b4b27657455"
        ]
    }
    
    var baseUrl: String { "https://newsapi.org/v2" }
}
