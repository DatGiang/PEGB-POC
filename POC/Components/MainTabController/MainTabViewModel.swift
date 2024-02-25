//
//  MainTabViewModel.swift
//  POC
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import PEGBCore
import PEGBUseCases
import UIKit

class MainTabViewModel: NSObject, ViewModel {
    let isLogout = Dynamic<Bool>(false)
    var newsDetailsNavigatable = Dynamic<Bool>(false)

    var topHeadlinesViewModel: BaseContentViewModel!
    var savedNewsViewModel: BaseContentViewModel!
    var newsDetailsViewModel: NewsDetailsViewModel!

    override init() {
        super.init()
        topHeadlinesViewModel = TopHeadlinesViewModel(delegate: self)
        savedNewsViewModel = SavedNewsViewModel(delegate: self)

        NotificationCenter.default.addObserver(forName: .NewsDataSynchronizerChanged, object: nil, queue: nil) { [weak self] _ in
            guard let self else { return }
            self.topHeadlinesViewModel.reload()
            self.savedNewsViewModel.reload()
        }
    }

    func getTopHeadlinesNews() {
        NewsRequesterUseCase().getTopHeadlines { [weak self] in
            guard let self else { return }
            switch $0 {
            case .failure: break
            case let .success(news):
                self.topHeadlinesViewModel.fetchAllNews(news: news)
                self.savedNewsViewModel.fetchAllNews(news: news)
            }
        }
    }
}

extension MainTabViewModel: BaseContentViewModelDelegate {
    func baseContentViewModelDidTapLogout() {
        isLogout.value = true
    }

    func baseContentViewModelDidTapNews(news: NewsResponse) {
        newsDetailsViewModel = .init(news: news)
        newsDetailsNavigatable.value = true
    }
}
