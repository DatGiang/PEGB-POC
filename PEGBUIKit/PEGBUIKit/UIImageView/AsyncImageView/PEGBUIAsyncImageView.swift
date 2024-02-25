//
//  PEGBUIAsyncImageView.swift
//  PEGBUIKit
//
//  Created by Dat Giang on 25/02/2024.
//

import Foundation
import PEGBCore
import UIKit

public class PEGBUIAsyncImageView: UIImageView, View {
    public var viewModel: PEGBUIAsyncImageViewModel?
    public var url: URL? {
        didSet {
            guard let url = url else { return }
            viewModel?.loadImage(from: url)
        }
    }
    public init(viewModel: PEGBUIAsyncImageViewModel? = PEGBUIAsyncImageViewModel()) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        bindViewModel()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        bindViewModel()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        bindViewModel()
    }
}

extension PEGBUIAsyncImageView {
    private func bindViewModel() {
        viewModel?.image.bind { [weak self] in
            self?.image = $0
        }
    }
}
