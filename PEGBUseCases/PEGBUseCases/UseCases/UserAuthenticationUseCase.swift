//
//  UserAuthenticationUseCase.swift
//  PEGBUseCases
//
//  Created by Dat Giang on 25/02/2024.
//

import Foundation
import PEGBCore
import Storage

public typealias UserAuthenticationResponse = (Result<Void, Error>) -> Void

public struct UserAuthenticationUseCase: Startable {
    
    public var dataChangedListener: DataChangedListener?
    
    public init() {}

    public func start() {
        listenDataChange()
    }

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

    public func addOrRemoveSavedNews(news: NewsResponse, completion: (Result<Void, Error>) -> Void) {
        let helper = UserRepositoryHelper()
        getLoggedInUser {
            switch $0 {
            case let .success(user):
                if let savedNews = (user.savedNews as? Set<CDNews>)?.first(where: { cdNews in
                    cdNews.url == news.url
                }) {
                    user.removeFromSavedNews(savedNews)
                    helper.updateUser(cdUser: user, completion: completion)
                } else {
                    let newsHelper = NewsSynchronizationHelper()
                    newsHelper.saveIfNeeded(news: news) { result in
                        switch result {
                        case let .success(news):
                            user.addToSavedNews(news)
                            helper.updateUser(cdUser: user, completion: completion)
                        case let .failure(error):
                            completion(.failure(error))
                        }
                    }
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    public func getSavedNews(news: NewsResponse, completion: (Result<CDNews, Error>) -> Void) {
        getLoggedInUser {
            switch $0 {
            case let .success(user):
                if let savedNews = (user.savedNews as? Set<CDNews>)?.first(where: { cdNews in
                    cdNews.url == news.url
                }) {
                    completion(.success(savedNews))
                } else {
                    completion(.failure(NewsCachingError.notFound))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    public func getListSavedNews(completion: (Result<[CDNews], Error>) -> Void) {
        getLoggedInUser {
            switch $0 {
            case let .success(user):
                if let listSavedNews = user.savedNews as? Set<CDNews> {
                    let listNews = listSavedNews.map { $0 }
                    completion(.success(listNews))
                } else {
                    completion(.failure(NewsCachingError.notFound))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

extension UserAuthenticationUseCase {
    private func listenDataChange() {
        CoreDataManagerImpl.shared.publishableContextChangedListener = {
            self.dataChangedListener?()
        }
    }
}
