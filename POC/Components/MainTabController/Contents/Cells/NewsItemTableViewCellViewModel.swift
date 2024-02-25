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
}
