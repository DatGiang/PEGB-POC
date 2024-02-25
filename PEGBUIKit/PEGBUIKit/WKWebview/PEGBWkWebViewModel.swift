//
//  PEGBWkWebViewModel.swift
//  PEGBUIKit
//
//  Created by Dat Giang on 25/02/2024.
//

import Foundation
import PEGBCore

public protocol PEGBWkWebViewModelDelegate: AnyObject {
    func pegbWkWebViewModelLoadingDidFailed(with error: Error)
}

public class PEGBWkWebViewModel: NSObject, ViewModel {
    public weak var delegate: PEGBWkWebViewModelDelegate?
    
    public init(delegate: PEGBWkWebViewModelDelegate? = nil) {
        self.delegate = delegate
    }
    
    func onLoadFail(with error: Error) {
        delegate?.pegbWkWebViewModelLoadingDidFailed(with: error)
    }
}
