//
//  Request.swift
//  Networking
//
//  Created by Dat Giang on 25/02/2024.
//

import Foundation

public enum Request {
    case get(path: String)
    case post(path: String)
    case put(path: String)
    case patch(path: String)
    case delete(path: String)

    enum HttpMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }

    public var path: String {
        switch self {
        case let .get(path),
             let .post(path),
             let .put(path),
             let .patch(path),
             let .delete(path):
            return path
        }
    }

    var method: HttpMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        case .put:
            return .put
        case .patch:
            return .patch
        case .delete:
            return .delete
        }
    }
}
