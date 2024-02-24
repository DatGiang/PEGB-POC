//
//  MainTabViewModel.swift
//  POC
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import PEGBCore

class MainTabViewModel: NSObject, ViewModel {
    let isLogout = Dynamic<Bool>(false)
    var newsDetailsNavigatable = Dynamic<Bool>(false)
    var baseContentViewModel: BaseContentViewModel!
    var newsDetailsViewModel: NewsDetailsViewModel!

    override init() {
        super.init()
        baseContentViewModel = .init(delegate: self)
    }
}

extension MainTabViewModel: BaseContentViewModelDelegate {
    func baseContentViewModelDidTapLogout() {
        isLogout.value = true
    }

    func baseContentViewModelDidTapNews() {
        newsDetailsViewModel = .init()
        newsDetailsNavigatable.value = true
    }
}
