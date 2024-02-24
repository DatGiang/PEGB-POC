//
//  TopHeadlinesViewController.swift
//  POC
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import UIKit

class TopHeadlinesViewController: BaseViewController {
    private lazy var navigationBarView: PEGBUINavigationBar = {
        let view = PEGBUINavigationBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func loadView() {
        super.loadView()
        setupViews()
    }
}

extension TopHeadlinesViewController {
    private func setupViews() {
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        view.addSubview(navigationBarView)
        NSLayoutConstraint.activate([
            navigationBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        navigationBarView.avatarImageView.title = "A"
        navigationBarView.title = "Search"
    }
}
