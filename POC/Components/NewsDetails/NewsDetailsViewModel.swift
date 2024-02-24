//
//  NewsDetailsViewModel.swift
//  POC
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import PEGBCore

class NewsDetailsViewModel: NSObject, ViewModel {
    var navigationViewModel: NewsDetailNavigationViewModel!
    let isCloseNewsDetails = Dynamic<Bool>(false)
    
    override init() {
        super.init()
        navigationViewModel = .init(delegate: self)
    }
}

extension NewsDetailsViewModel: NewsDetailNavigationViewModelDelegate {
    func didTapClose() { isCloseNewsDetails.value = true }
    func didTapBookmark() {}
}
