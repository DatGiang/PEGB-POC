//
//  SavedNewsViewModel.swift
//  POC
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import PEGBCore
import PEGBUseCases
import Storage
import UIKit

class SavedNewsViewModel: BaseContentViewModel {
    override func bindShowNews() {
        self.shownNews.value = self.allNews.value.filter { $0.1 }
    }
    
    func loadOffline() {
        savedNewsData.getListSavedNews { [weak self] in
            switch $0 {
            case let .success(listCDNews):
                self?.shownNews.value = listCDNews.map {
                    ($0.convertToResponse(), true)
                }
            case .failure: break
            }
        }
    }
}

extension CDNews {
    func convertToResponse() -> NewsResponse {
        NewsResponse(
            author: author,
            title: title, url: url,
            urlToImage: imageUrl,
            publishedAt: publishedAt?.toString(by: DateFormat.iso8601DateFormat1.rawValue),
            content: content
        )
    }
}
