//
//  SavedNewsViewModel.swift
//  POC
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import PEGBUseCases
import UIKit

class SavedNewsViewModel: BaseContentViewModel {
    private let newsData: NewsDataSynchronizationUseCase = .init()
    
    override init(delegate: BaseContentViewModelDelegate?) {
        super.init(delegate: delegate)
        
        (UIApplication.shared.delegate as? AppDelegate)?.newsDataSynchronizerListener = { [weak self] in
            guard let self else { return }
            self.filterShownNews(from: self.allNews.value)
        }
    }
    
    override func bindShowNews(from allNews: [NewsResponse]) {
        filterShownNews(from: allNews)
    }
}

extension SavedNewsViewModel {
    private func filterShownNews(from originalNews: [NewsResponse]) {
        newsData.getAll { [weak self] in
            guard let self else { return }
            switch $0 {
            case let .failure(error): break
            case let .success(listCDNews):
                self.shownNews.value = originalNews.filter { news in
                    listCDNews.contains {
                        $0.url == news.url
                    }
                }
            }
        }
    }
}
