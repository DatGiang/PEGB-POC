//
//  Requestable.swift
//  Networking
//
//  Created by Dat Giang on 25/02/2024.
//

import Foundation

public protocol Requestable {
    /// The parameters that should be included in the request URL
    /// Example: /api/user?parameter=true&anotherparameter="example"
    var parameters: [String: Any]? { get }

    /// The body to be included in the request
    var body: [String: Any]? { get }

    /// The  HTTP method to be used in the request along with its endpoint
    /// Example: .post("/users")
    var request: Request { get }
    /// The request url string address to be appended along with the base URL
    var url: String { get }

    /// The Authorization Token to be used in the request.
    /// Right now the only supported authorization type is a Bearer token
    var token: String? { get }

    /// An optional set of HTTP request header field-value pairs to set for this request.
    var headers: [String: String]? { get }
}

extension Requestable {
    var urlRequest: URLRequest {
        var components = URLComponents(string: url)

        // URLComponents(string: url) can't init with url params contains double quote
        if components == nil, let urlQueryAllowed = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            components = URLComponents(string: urlQueryAllowed)
        }
        
        if let parameters = parameters {
            components?.addQueryParameters(params: parameters)
        }

        guard let urlWithParameters = components?.url else {
            return URLRequest(url: URL(fileURLWithPath: ""))
        }

        var urlRequest = URLRequest(url: urlWithParameters)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.addApplicationJsonContentAndAcceptHeaders()

        for (headerField, value) in headers ?? [:] {
            urlRequest.addValue(value, forHTTPHeaderField: headerField)
        }

        if let token = token {
            urlRequest.setBearerToken(token)
        }

        if let body = body, let data = try? JSONSerialization.data(withJSONObject: body) {
            urlRequest.httpBody = data
        }

        return urlRequest
    }
}

extension URLComponents {
    mutating func addQueryParameters(params: [String: Any]) {
        queryItems = [URLQueryItem]()
        for (key, value) in params {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            queryItems?.append(queryItem)
        }
    }
}
