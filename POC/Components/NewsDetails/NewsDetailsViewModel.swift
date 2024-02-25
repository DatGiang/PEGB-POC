//
//  NewsDetailsViewModel.swift
//  POC
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import PEGBCore
import PEGBUseCases
import PEGBUIKit

class NewsDetailsViewModel: NSObject, ViewModel {
    let news: Dynamic<NewsResponse>
    var navigationViewModel: NewsDetailNavigationViewModel!
    var webViewModel: PEGBWkWebViewModel!
    var offlineViewModel: OfflineViewModel?
    let isCloseNewsDetails = Dynamic<Bool>(false)
    let isWebviewLoadingFailed = Dynamic<Bool>(false)
    
    init(news: NewsResponse) {
        self.news = .init(news)
        super.init()
        navigationViewModel = .init(delegate: self)
        webViewModel = .init(delegate: self)
    }
}

extension NewsDetailsViewModel: NewsDetailNavigationViewModelDelegate {
    func didTapClose() { isCloseNewsDetails.value = true }
    func didTapBookmark() {}
}

extension NewsDetailsViewModel: PEGBWkWebViewModelDelegate {
    func pegbWkWebViewModelLoadingDidFailed(with error: Error) {
        offlineViewModel = OfflineViewModel(news: news.value)
        isWebviewLoadingFailed.value = true
    }
}
