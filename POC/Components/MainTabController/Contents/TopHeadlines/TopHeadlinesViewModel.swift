//
//  TopHeadlinesViewModel.swift
//  POC
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import PEGBUseCases
import UIKit

class TopHeadlinesViewModel: BaseContentViewModel {
    override func bindShowNews(from allNews: [NewsResponse]) {
        shownNews.value = allNews
    }
}
