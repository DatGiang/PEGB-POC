//
//  PEGBUINavigationBarViewModel.swift
//  POC
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import PEGBCore

protocol PEGBUINavigationBarViewModelDelegate: AnyObject {
    func navigationBarDidTapLogout()
}

class PEGBUINavigationBarViewModel: NSObject, ViewModel {
    private weak var delegate: PEGBUINavigationBarViewModelDelegate?
    
    init(delegate: PEGBUINavigationBarViewModelDelegate?) {
        super.init()
        self.delegate = delegate
    }
    
    func didTapLogout() {
        delegate?.navigationBarDidTapLogout()
    }
}
