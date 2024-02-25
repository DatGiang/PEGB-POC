//
//  UserRepositoryHelper.swift
//  PEGBUseCases
//
//  Created by Dat Giang on 25/02/2024.
//

import Foundation
import Storage

struct UserRepositoryHelper {
    private let userRepository: CoreDataRepository<CDUser> = .init(context: CoreDataManagerImpl.shared.publishableManagedObjectContext)
    
    func getUser(
        by username: String,
        and password: String,
        completion: (Result<CDUser, Error>) -> Void
    ) {
        userRepository.fetch(
            predicate: NSPredicate(format: "username == %@ AND password == %@", username, password)) {
                switch $0 {
                case let .success(users):
                    if let user = users.first {
                        completion(.success(user))
                    } else {
                        completion(.failure(UserAuthenticationError.userNotFound))
                    }
                case let .failure(error): completion(.failure(error))
                }
            }
    }
    
    func updateUser(cdUser: CDUser, completion: (Result<Void, Error>) -> Void) {
        userRepository.update(cdUser, completion: completion)
    }
    
    func getLoggedInUser(completion: (Result<CDUser, Error>) -> Void) {
        userRepository.fetch(
            predicate: NSPredicate(format: "isLoggedIn == %@", NSNumber(value: true))) {
                switch $0 {
                case let .success(users):
                    if let user = users.first {
                        completion(.success(user))
                    } else {
                        completion(.failure(UserAuthenticationError.userNotFound))
                    }
                case let .failure(error): completion(.failure(error))
                }
            }
    }
}
