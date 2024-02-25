//
//  Network.swift
//  Networking
//
//  Created by Dat Giang on 25/02/2024.
//

import Foundation

public struct Network<R: Requestable> {
    private let session = URLSession.shared

    public init() {}
    
    /// Decodable version of the send function that also returns the HTTPURLResponse
    public func sendAndGetResponse<T: Decodable>(
        _ request: R,
        decoder: JSONDecoder = JSONDecoder(),
        completion: @escaping (Result<(T, HTTPURLResponse), Error>) -> Void
    ) {
        printLog("REQUEST: \(requestDescription(request))")
        printLog(request.urlRequest.curlString())
        
        session.dataTask(with: request.urlRequest) { data, response, error in
            DispatchQueue.main.async {
                printLog("RESPONSE: \(requestDescription(request))")
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(.failure(HttpError.notFound))
                    return
                }
                
                printLog("\(NSString(data: data, encoding: NSUTF8StringEncoding) ?? "")")
                
                if let httpErrorData = HttpErrorData(from: data, response: response) {
                    printLog(requestFailureDescription(request, httpErrorData: httpErrorData))
                    completion(.failure(httpErrorData))
                    return
                }
                
                do {
                    var responseDecoded: T
                    if data.isEmpty {
                        let json = Data("{}".utf8)
                        responseDecoded = try decoder.decode(T.self, from: json)
                    } else {
                        responseDecoded = try decoder.decode(T.self, from: data)
                    }
                    completion(.success((responseDecoded, response)))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        .resume()
    }
}

private func requestDescription<R: Requestable>(_ request: R) -> String {
    "\(request.urlRequest.methodAndUrlDescription): \(request.body?.description ?? "nil")"
}

private func requestFailureDescription<R: Requestable>(
    _ request: R,
    httpErrorData: HttpErrorData
) -> String {
    "Request failed: \(request.urlRequest.methodAndUrlDescription), " +
        "\(httpErrorData.underlyingError), message: \(httpErrorData.message)"
}

private func printLog(_ data: Any) {
    #if DEBUG
    print(data)
    #endif
}
