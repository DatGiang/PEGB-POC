//
//  NewsDetailsNavigation.swift
//  POC
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import PEGBUIKit
import UIKit
import PEGBCore

class NewsDetailsNavigation: HorizontalViews, View {
    private lazy var bookmarkButton: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage(named: "bookmark")?.withRenderingMode(.alwaysOriginal), for: .normal)
        view.addTarget(self, action: #selector(didTapBookmark), for: .touchUpInside)
        return view
    }()

    private lazy var closeButton: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage(named: "xmark")?.withRenderingMode(.alwaysOriginal), for: .normal)
        view.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        return view
    }()
    
    var viewModel: NewsDetailNavigationViewModel?
    
    init(viewModel: NewsDetailNavigationViewModel?) {
        self.viewModel = viewModel
        super.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    @objc private func didTapBookmark() { viewModel?.didTapBookmark() }

    @objc private func didTapClose() { viewModel?.didTapClose() }
}

extension NewsDetailsNavigation {
    private func setupViews() {
        setupBookmarkButton()
        setupCloseButton()
    }

    private func setupBookmarkButton() {
        let bookmarkView = UIView()
        bookmarkView.translatesAutoresizingMaskIntoConstraints = false

        bookmarkView.addSubview(bookmarkButton)
        NSLayoutConstraint.activate([
            bookmarkButton.topAnchor.constraint(equalTo: bookmarkView.topAnchor, constant: UIConstants.Padding.small),
            bookmarkButton.leadingAnchor.constraint(equalTo: bookmarkView.leadingAnchor, constant: UIConstants.Padding.small),
            bookmarkButton.centerXAnchor.constraint(equalTo: bookmarkView.centerXAnchor),
            bookmarkButton.centerYAnchor.constraint(equalTo: bookmarkView.centerYAnchor),
            bookmarkButton.heightAnchor.constraint(equalToConstant: UIConstants.Sizes.iconSize.height),
            bookmarkButton.heightAnchor.constraint(equalTo: bookmarkButton.widthAnchor),
        ])

        addSubLeadingView(bookmarkView)
    }

    private func setupCloseButton() {
        let closeView = UIView()
        closeView.translatesAutoresizingMaskIntoConstraints = false

        closeView.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: closeView.topAnchor, constant: UIConstants.Padding.small),
            closeButton.leadingAnchor.constraint(equalTo: closeView.leadingAnchor, constant: UIConstants.Padding.small),
            closeButton.centerXAnchor.constraint(equalTo: closeView.centerXAnchor),
            closeButton.centerYAnchor.constraint(equalTo: closeView.centerYAnchor),
            closeButton.heightAnchor.constraint(equalToConstant: UIConstants.Sizes.iconSize.height),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
        ])

        addSubTrailingView(closeView)
    }
}
