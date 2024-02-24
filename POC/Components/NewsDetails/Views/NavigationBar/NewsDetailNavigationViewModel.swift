//
//  NewsDetailNavigationViewModel.swift
//  POC
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import PEGBCore

protocol NewsDetailNavigationViewModelDelegate: AnyObject {
    func didTapClose()
    func didTapBookmark()
}

class NewsDetailNavigationViewModel: NSObject, ViewModel {
    private weak var delegate: NewsDetailNavigationViewModelDelegate?
    
    init(delegate: NewsDetailNavigationViewModelDelegate? = nil) {
        self.delegate = delegate
        super.init()
    }
    
    func didTapClose() {
        delegate?.didTapClose()
    }
    
    func didTapBookmark() {
        delegate?.didTapBookmark()
    }
}
