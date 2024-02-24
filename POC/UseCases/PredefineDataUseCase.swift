//
//  PredefineDataUseCase.swift
//  POC
//
//  Created by Dat Giang on 25/02/2024.
//

import Foundation
import PEGBCore
import Storage

class PredefineDataUseCase: NSObject, Startable {
    private let userRepository: CoreDataRepository<CDUser> = .init(context: CoreDataManagerImpl.shared.backgroundManagedObjectContext)
    private static let users: [(username: String, password: String)] = [
        ("usera", "passworda"),
        ("userb", "passwordb"),
    ]

    func start() {
        predefineUsersIfNeeded()
    }
}

extension PredefineDataUseCase {
    private func predefineUsersIfNeeded() {
        userRepository.fetch { [weak self] in
            guard let self else {
                return
            }
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
