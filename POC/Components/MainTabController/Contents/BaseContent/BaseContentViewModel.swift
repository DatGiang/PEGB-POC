//
//  BaseContentViewModel.swift
//  POC
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import PEGBCore

protocol BaseContentViewModelDelegate: AnyObject {
    func baseContentViewModelDidTapLogout()
    func baseContentViewModelDidTapNews()
}

class BaseContentViewModel: NSObject, ViewModel {
    var navigationViewModel: PEGBUINavigationBarViewModel!
    private weak var delegate: BaseContentViewModelDelegate?
    
    init(delegate: BaseContentViewModelDelegate?) {
        super.init()
        navigationViewModel = .init(delegate: self)
        self.delegate = delegate
    }
    
    func navigateToNewsDetails() {
        delegate?.baseContentViewModelDidTapNews()
    }
}

extension BaseContentViewModel: PEGBUINavigationBarViewModelDelegate {
    func navigationBarDidTapLogout() {
        delegate?.baseContentViewModelDidTapLogout()
    }
}
