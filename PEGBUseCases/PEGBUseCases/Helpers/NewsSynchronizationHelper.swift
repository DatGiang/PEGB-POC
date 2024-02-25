//
//  NewsSynchronizationHelper.swift
//  PEGBUseCases
//
//  Created by Dat Giang on 25/02/2024.
//

import Foundation
import Storage

struct NewsSynchronizationHelper {
    private let newsRepository: CoreDataRepository<CDNews> = .init(context: CoreDataManagerImpl.shared.publishableManagedObjectContext)

    func saveNews(news: NewsResponse, completion: SaveNewsResult) {
        newsRepository.add { cdNews in
            cdNews.author = news.author
            cdNews.title = news.title
            cdNews.desc = news.description
            cdNews.url = news.url
            cdNews.imageUrl = news.urlToImage
            cdNews.publishedAt = news.publishedAt?.convertToDate(with: .iso8601DateFormat1)
            cdNews.content = news.content
        } completion: {
            switch $0 {
            case .success: completion(.success(()))
            case let .failure(error): completion(.failure(error))
            }
        }
    }

    func delete(cdNews: CDNews, completion: SaveNewsResult) {
        newsRepository.delete(cdNews, completion: completion)
    }
}
