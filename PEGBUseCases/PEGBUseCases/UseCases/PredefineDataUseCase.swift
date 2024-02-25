//
//  PredefineDataUseCase.swift
//  POC
//
//  Created by Dat Giang on 25/02/2024.
//

import Foundation
import PEGBCore
import Storage

public struct PredefineDataUseCase: Startable {
    public init() {}
    private let userRepository: CoreDataRepository<CDUser> = .init(context: CoreDataManagerImpl.shared.backgroundManagedObjectContext)
    private static let users: [(username: String, password: String)] = [
        ("usera", "passworda"),
        ("userb", "passwordb"),
    ]

    public func start() {
        predefineUsersIfNeeded()
    }
}

extension PredefineDataUseCase {
    private func predefineUsersIfNeeded() {
        userRepository.fetch {
            switch $0 {
            case .failure:
                self.addPredefinedUsers()
            case .success:
                break
            }
        }
    }

    private func addPredefinedUsers() {
        for user in Self.users {
            userRepository.add { cdUser in
                cdUser.username = user.username
                cdUser.password = user.password
            } completion: { _ in }
        }
    }
}
