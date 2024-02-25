//
//  URLRequest+Extensions.swift
//  Networking
//
//  Created by Dat Giang on 25/02/2024.
//

import Foundation

extension URLRequest {
    // Returns a curl command that can be used to invoke this request at the command line.
    ///
    /// Taken from http://gentlebytes.com/blog/2018/02/28/request-debugging/
    ///
    /// Logging URL requests in whole may expose sensitive data, or open up the possibility for
    /// getting access to your user data, so make sure to disable this feature for production
    /// builds!
    public func curlString(pretty: Bool = false) -> String {
        #if !DEBUG
        return ""
        #else
        let newLine = pretty ? "\\\n" : ""
        let method = (pretty ? "--request " : "-X ") + "\(self.httpMethod ?? "GET") \(newLine)"
        let url: String = (pretty ? "--url " : "") + "'\(self.url?.absoluteString ?? "")' \(newLine)"
        
        var cURL = "curl "
        var header = ""
        var data: String = ""
        
        if let httpHeaders = self.allHTTPHeaderFields, httpHeaders.keys.count > 0 {
            for (key,value) in httpHeaders {
                header += (pretty ? "--header " : "-H ") + "'\(key): \(value)' \(newLine)"
            }
        }
        
        if let bodyData = self.httpBody, let bodyString = String(data: bodyData, encoding: .utf8),  !bodyString.isEmpty {
            data = "--data '\(bodyString)'"
        }
        
        cURL += method + url + header + data
        
        return cURL
        #endif
    }
    
    public var methodAndUrlDescription: String {
        guard let httpMethod = httpMethod, let url = url else {
            return debugDescription
        }

        return "\(httpMethod) \(url)"
    }
    
    public mutating func addApplicationJsonContentAndAcceptHeaders() {
        let value = "application/json"
        addValue(value, forHTTPHeaderField: "Content-Type")
        addValue(value, forHTTPHeaderField: "Accept")
    }
    
    public mutating func setBearerToken(_ token: String) {
        setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
}
