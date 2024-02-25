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
        view.backgroundColor = .white.withAlphaComponent(0.7)
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
        view.isHidden = false
        return view
    }()
    
    private lazy var offlineView: OfflineView = {
        let view = OfflineView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
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
        bindViewModel()
    }
}

extension NewsDetailsViewController {
    func setupViews() {
        setupStackView()
        setupNavigationBarView()
        setupWebview()
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
        webView.viewModel = viewModel?.webViewModel
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
        viewModel?.news.bindAndFire { [weak self] in
            self?.webView.url = $0.url ?? ""
        }
        viewModel?.isWebviewLoadingFailed.bind { [weak self] in
            if $0 {
                self?.webView.isHidden = true
                self?.offlineView.isHidden = false
                self?.offlineView.viewModel = self?.viewModel?.offlineViewModel
            }
        }
        viewModel?.isSaved.bindAndFire { [weak self] in
            self?.navigationBarView.bookmarkButton.setImage(UIImage(named: $0 ? "bookmark.fill" : "bookmark")?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
}
