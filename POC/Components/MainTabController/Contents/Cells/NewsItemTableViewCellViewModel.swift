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
    let news: Dynamic<NewsResponse>
    
    init(news: NewsResponse) {
        self.news = .init(news)
    }
    
    func onTapBookmark() {
        let newsDataSynchronize: NewsDataSynchronizationUseCase = .init()
        newsDataSynchronize.saveOrDelete(news: news.value) {
            switch $0 {
            case let .failure(error): break
            case .success: break
            }
        }
        
    }
}
