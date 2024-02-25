//
//  NewsDataSynchronizationUseCase.swift
//  PEGBUseCases
//
//  Created by Dat Giang on 25/02/2024.
//

import Foundation
import Storage
import PEGBCore

public typealias SaveNewsResult = (Result<Void, Error>) -> Void
public typealias GetListNewsResult = (Result<[CDNews], Error>) -> Void
public typealias GetNewsResult = (Result<CDNews, Error>) -> Void
public typealias DataChangedListener = () -> Void

public struct NewsDataSynchronizationUseCase: Startable {
    private let newsRepository: CoreDataRepository<CDNews> = .init(context: CoreDataManagerImpl.shared.publishableManagedObjectContext)
    
    public var dataChangedListener: DataChangedListener?
    
    public init() {}
    
    public func start() {
        listenDataChange()
    }
    
    public func saveOrDelete(news: NewsResponse, completion: SaveNewsResult) {
        let helper = NewsSynchronizationHelper()
        newsRepository.fetch(predicate: NSPredicate(format: "url == %@", news.url ?? "")) {
            switch $0 {
            case .failure:
                helper.saveNews(news: news, completion: completion)
            case let .success(existings):
                guard let cdNews = existings.first else {
                    helper.saveNews(news: news, completion: completion)
                    return
                }
                helper.delete(cdNews: cdNews, completion: completion)
            }
        }
    }
    
    public func get(news: NewsResponse, completion: GetNewsResult) {
        newsRepository.fetch(predicate: NSPredicate(format: "url == %@", news.url ?? "")) {
            switch $0 {
            case let .failure(error):
                completion(.failure(error))
            case let .success(existings):
                guard let news = existings.first else {
                    return
                }
                completion(.success(news))
            }
        }
    }
    
    public func getAll(completion: GetListNewsResult) {
        newsRepository.fetch() {
            switch $0 {
            case let .failure(error):
                if case RepositoryError.objectNotFound = error {
                    completion(.success([]))
                } else {
                    completion(.failure(error))
                }
            case let .success(existings): completion(.success(existings))
            }
        }
    }
}

extension NewsDataSynchronizationUseCase {
    private func listenDataChange() {
        CoreDataManagerImpl.shared.publishableContextChangedListener = {
            self.dataChangedListener?()
        }
    }
}
