//
//  NewsDetailsViewController.swift
//  POC
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import PEGBUIKit
import UIKit
import PEGBCore

class NewsDetailsViewController: BaseViewController, View {
    private lazy var navigationBarView: NewsDetailsNavigation = {
        let view = NewsDetailsNavigation()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        return view
    }()

    private lazy var webView: PEGBWKWebview = {
        let view = PEGBWKWebview()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.navigationDelegate = self
        return view
    }()
    
    private lazy var offlineView: OfflineView = {
        let view = OfflineView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewModel: NewsDetailsViewModel?
    
    init(viewModel: NewsDetailsViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func loadView() {
        super.loadView()
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        webView.url = "https://www.washingtonpost.com/technology/2024/02/22/moon-landing-intuitive-machines-odysseus-nasa-live/"
        bindViewModel()
    }
}

extension NewsDetailsViewController {
    func setupViews() {
        setupStackView()
        setupNavigationBarView()
        setupOfflineView()
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupNavigationBarView() {
        navigationBarView.viewModel = viewModel?.navigationViewModel
        view.addSubview(navigationBarView)
        NSLayoutConstraint.activate([
            navigationBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setupWebview() {
        stackView.addArrangedSubview(webView)
    }
    
    private func setupOfflineView() {
        stackView.addArrangedSubview(offlineView)
    }
}

extension NewsDetailsViewController {
    private func bindViewModel() {
        viewModel?.isCloseNewsDetails.bind { [weak self] in
            if $0 { self?.navigationController?.popViewController(animated: true) }
        }
    }
}
