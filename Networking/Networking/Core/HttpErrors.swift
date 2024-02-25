//
//  HttpErrors.swift
//  Networking
//
//  Created by Dat Giang on 25/02/2024.
//

import Foundation

struct HttpErrorData: Error, Equatable {
    public let data: Data
    public let underlyingError: HttpError
    public var message: String {
        let defaultMessage = String(data: data, encoding: .utf8) ?? "<none>"
        return defaultMessage
    }

    init?(from data: Data, response: URLResponse) {
        guard let error = HttpError(from: response) else { return nil }
        self.data = data
        self.underlyingError = error
    }
}

public enum HttpError: Error {
    /// Client Errors
    case badRequest, unauthorized, forbidden, notFound, methodNotAllowed, timeout, general
    /// Server Errors
    case internalServerError, notImplemented, badGateway, serviceUnavailable, gatewayTimeout

    init?(from response: URLResponse) {
        guard
            let response = response as? HTTPURLResponse,
            response.statusCode >= 400 && response.statusCode <= 511
        else { return nil }

        switch response.statusCode {
        case 400:
            self = .badRequest
        case 401:
            self = .unauthorized
        case 403:
            self = .forbidden
        case 404:
            self = .notFound
        case 405:
            self = .methodNotAllowed
        case 408:
            self = .timeout
        case 500:
            self = .internalServerError
        case 501:
            self = .notImplemented
        case 502:
            self = .badGateway
        case 503:
            self = .serviceUnavailable
        case 504:
            self = .gatewayTimeout
        default:
            self = .general
        }
    }
}

enum SerializationError: Error {
    case failedToDecode, failedToEncode
}
