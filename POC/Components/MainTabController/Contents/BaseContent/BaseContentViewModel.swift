//
//  BaseContentViewModel.swift
//  POC
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import PEGBCore
import PEGBUseCases
import UIKit

typealias NewsAndSave = (NewsResponse, Bool)

protocol BaseContentViewModelDelegate: AnyObject {
    func baseContentViewModelDidTapLogout()
    func baseContentViewModelDidTapNews(news: NewsResponse)
}

class BaseContentViewModel: NSObject, ViewModel {
    let newsData: NewsDataSynchronizationUseCase = .init()
    var navigationViewModel: PEGBUINavigationBarViewModel!
    private weak var delegate: BaseContentViewModelDelegate?
    private var originalNews: [NewsResponse] = []
    var allNews: Dynamic<[NewsAndSave]> = .init([])
    var shownNews: Dynamic<[NewsAndSave]> = .init([])
    
    init(delegate: BaseContentViewModelDelegate?) {
        super.init()
        navigationViewModel = .init(delegate: self)
        self.delegate = delegate
    }
    
    func navigateToNewsDetails(at indexPath: IndexPath) {
        let news: NewsResponse = shownNews.value[indexPath.row].0
        delegate?.baseContentViewModelDidTapNews(news: news)
    }
    
    func fetchAllNews(news: [NewsResponse]) {
        originalNews = news
        mergeRemoteAndLocalNews(from: news)
        bindShowNews()
    }
    
    func reload() {
        mergeRemoteAndLocalNews(from: originalNews)
        bindShowNews()
    }
    
    func bindShowNews() {
        preconditionFailure("This method must be overridden")
    }
    
    func contentTableViewNumberOfRowsInSection(section: Int) -> Int {
        shownNews.value.count
    }
    
    func contentTableViewHeightForRows(at indexPath: IndexPath) -> CGFloat { 144 }
    
    func contentTableViewCellViewModel(at indexPath: IndexPath) -> NewsItemTableViewCellViewModel {
        let news: NewsAndSave = shownNews.value[indexPath.row]
        let viewModel = NewsItemTableViewCellViewModel(news: news)
        viewModel.news.value = news
        return viewModel
    }
}

extension BaseContentViewModel: PEGBUINavigationBarViewModelDelegate {
    func navigationBarDidTapLogout() {
        delegate?.baseContentViewModelDidTapLogout()
    }
}

extension BaseContentViewModel {
    private func mergeRemoteAndLocalNews(from remoteNews: [NewsResponse]) {
        newsData.getAll { [weak self] in
            guard let self else { return }
            switch $0 {
            case let .failure(error):
                self.allNews.value = remoteNews.map { ($0, false) }
            case let .success(listCDNews):
                self.allNews.value = remoteNews.map { newsResponse in
                    let isExisted = listCDNews.contains {
                        $0.url == newsResponse.url
                    }
                    return (newsResponse, isExisted)
                }
            }
        }
    }
}
