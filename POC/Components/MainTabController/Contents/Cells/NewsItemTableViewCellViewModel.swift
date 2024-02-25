//
//  NewsItemTableViewCellViewModel.swift
//  POC
//
//  Created by Dat Giang on 25/02/2024.
//

import Foundation
import PEGBCore
import PEGBUseCases

class NewsItemTableViewCellViewModel: NSObject, ViewModel {
    let news: Dynamic<NewsAndSave>
    
    init(news: NewsAndSave) {
        self.news = .init(news)
    }
    
    func onTapBookmark() {
        let savedNewsDataSynchronize: UserAuthenticationUseCase = .init()
        savedNewsDataSynchronize.addOrRemoveSavedNews(news: news.value.0) { _ in }
    }
}
