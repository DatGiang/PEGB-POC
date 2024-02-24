//
//  View.swift
//  PEGBCore
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation

public protocol View {
    associatedtype ViewModelType: ViewModel
    var viewModel: ViewModelType? { get set }
}
