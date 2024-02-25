//
//  BaseContentViewModel.swift
//  POC
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import PEGBCore
import PEGBUseCases

protocol BaseContentViewModelDelegate: AnyObject {
    func baseContentViewModelDidTapLogout()
    func baseContentViewModelDidTapNews()
}

class BaseContentViewModel: NSObject, ViewModel {
    var navigationViewModel: PEGBUINavigationBarViewModel!
    private weak var delegate: BaseContentViewModelDelegate?
    private var allNews: Dynamic<[NewsResponse]> = .init([])
    var shownNews: Dynamic<[NewsResponse]> = .init([])
    
    init(delegate: BaseContentViewModelDelegate?) {
        super.init()
        navigationViewModel = .init(delegate: self)
        self.delegate = delegate
    }
    
    func navigateToNewsDetails() {
        delegate?.baseContentViewModelDidTapNews()
    }
    
    func setAllNews(news: [NewsResponse]) {
        self.allNews.value = news
        bindShowNews(from: news)
    }
    
    func bindShowNews(from allNews: [NewsResponse]) {
        preconditionFailure("This method must be overridden")
    }
    
    func contentTableViewNumberOfRowsInSection(section: Int) -> Int {
        shownNews.value.count
    }
    
    func contentTableViewHeightForRows(at indexPath: IndexPath) -> CGFloat { 144 }
    
    func contentTableViewCellViewModel(at indexPath: IndexPath) -> NewsItemTableViewCellViewModel {
        let news: NewsResponse = shownNews.value[indexPath.row]
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
