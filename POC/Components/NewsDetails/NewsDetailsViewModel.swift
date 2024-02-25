//
//  NewsDetailsViewModel.swift
//  POC
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import PEGBCore
import PEGBUIKit
import PEGBUseCases
import UIKit

class NewsDetailsViewModel: NSObject, ViewModel {
    private let newsData: NewsDataSynchronizationUseCase = .init()
    let news: Dynamic<NewsResponse>
    var navigationViewModel: NewsDetailNavigationViewModel!
    var webViewModel: PEGBWkWebViewModel!
    var offlineViewModel: OfflineViewModel?
    let isCloseNewsDetails = Dynamic<Bool>(false)
    let isWebviewLoadingFailed = Dynamic<Bool>(false)
    let isSaved = Dynamic<Bool>(false)

    init(news: NewsResponse) {
        self.news = .init(news)
        super.init()
        navigationViewModel = .init(delegate: self)
        webViewModel = .init(delegate: self)
        getSaveStatus()
        NotificationCenter.default.addObserver(forName: .NewsDataSynchronizerChanged, object: nil, queue: nil) { [weak self] _ in
            guard let self else { return }
            self.getSaveStatus()
        }
    }
}

extension NewsDetailsViewModel {
    private func getSaveStatus() {
        newsData.get(news: news.value) {
            switch $0 {
            case let .failure(error):
                isSaved.value = false
            case .success:
                isSaved.value = true
            }
        }
    }
}

extension NewsDetailsViewModel: NewsDetailNavigationViewModelDelegate {
    func didTapClose() { isCloseNewsDetails.value = true }
    func didTapBookmark() { newsData.saveOrDelete(news: news.value) { _ in } }
}

extension NewsDetailsViewModel: PEGBWkWebViewModelDelegate {
    func pegbWkWebViewModelLoadingDidFailed(with error: Error) {
        offlineViewModel = OfflineViewModel(news: news.value)
        isWebviewLoadingFailed.value = true
    }
}
