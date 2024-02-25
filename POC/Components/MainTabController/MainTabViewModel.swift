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
import Storage

class MainTabViewModel: NSObject, ViewModel {
    var newsDetailsNavigatable = Dynamic<Bool>(false)

    var loginViewModel: LoginViewModel!
    var topHeadlinesViewModel: BaseContentViewModel!
    var savedNewsViewModel: BaseContentViewModel!
    var newsDetailsViewModel: NewsDetailsViewModel!

    override init() {
        super.init()
        topHeadlinesViewModel = TopHeadlinesViewModel(delegate: self)
        savedNewsViewModel = SavedNewsViewModel(delegate: self)
        
        let fetchUser = {
            UserAuthenticationUseCase().getLoggedInUser { [weak self] in
                guard let self else { return }
                switch $0 {
                case .failure: break
                case let .success(user):
                    self.topHeadlinesViewModel.fetchUserInfo(user: user)
                    self.savedNewsViewModel.fetchUserInfo(user: user)
                }
            }
        }

        fetchUser()
        NotificationCenter.default.addObserver(forName: .SavedNewsDataSynchronizerChanged, object: nil, queue: nil) { [weak self] _ in
            guard let self else { return }
            self.topHeadlinesViewModel.reload()
            self.savedNewsViewModel.reload()
            fetchUser()
        }
    }

    func getTopHeadlinesNews() {
        NewsRequesterUseCase().getTopHeadlines { [weak self] in
            guard let self else { return }
            switch $0 {
            case .failure:
                (self.savedNewsViewModel as? SavedNewsViewModel)?.loadOffline()
            case let .success(news):
                self.topHeadlinesViewModel.fetchAllNews(news: news)
                self.savedNewsViewModel.fetchAllNews(news: news)
            }
        }
    }
}

extension MainTabViewModel: BaseContentViewModelDelegate {
    func baseContentViewModelDidTapLogout() {
        UserAuthenticationUseCase().logout { _ in }
    }

    func baseContentViewModelDidTapNews(news: NewsResponse) {
        newsDetailsViewModel = .init(news: news)
        newsDetailsNavigatable.value = true
    }
}
