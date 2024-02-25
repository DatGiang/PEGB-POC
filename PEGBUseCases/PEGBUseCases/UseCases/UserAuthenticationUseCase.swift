//
//  UserAuthenticationUseCase.swift
//  PEGBUseCases
//
//  Created by Dat Giang on 25/02/2024.
//

import Foundation
import Storage

public typealias UserAuthenticationResponse = (Result<Void, Error>) -> Void

public struct UserAuthenticationUseCase {
    public init() {}
    public func login(username: String, password: String, completion: UserAuthenticationResponse) {
        UserRepositoryHelper().getUser(by: username, and: password) {
            switch $0 {
            case .success: completion(.success(()))
            case let .failure(error): completion(.failure(error))
            }
        }
    }
}
