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
        let helper = UserRepositoryHelper()
        helper.getUser(by: username, and: password) {
            switch $0 {
            case let .success(user):
                user.isLoggedIn = true
                helper.updateUser(cdUser: user, completion: completion)
            case let .failure(error): completion(.failure(error))
            }
        }
    }
    
    public func logout(completion: UserAuthenticationResponse) {
        let helper = UserRepositoryHelper()
        helper.getLoggedInUser {
            switch $0 {
            case let .success(user):
                user.isLoggedIn = false
                helper.updateUser(cdUser: user, completion: completion)
            case let .failure(error): completion(.failure(error))
            }
        }
    }
    
    public func getLoggedInUser(completion: (Result<CDUser, Error>) -> Void) {
        let helper = UserRepositoryHelper()
        helper.getLoggedInUser {
            switch $0 {
            case let .success(user):
                completion(.success(user))
            case let .failure(error): completion(.failure(error))
            }
        }
    }
}
