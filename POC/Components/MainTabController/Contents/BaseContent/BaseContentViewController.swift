//
//  BaseContentViewController.swift
//  POC
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import PEGBUIKit
import UIKit
import PEGBCore

class BaseContentViewController: BaseViewController, View {
    private let kNewsItemTableViewCell = "NewsItemTableViewCell"
    
    private lazy var navigationBarView: PEGBUINavigationBar = {
        let view = PEGBUINavigationBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var searchTextField: PEGBUISearchTextField = {
        let view = PEGBUISearchTextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.separatorStyle = .none
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        view.register(NewsItemTableViewCell.self, forCellReuseIdentifier: kNewsItemTableViewCell)
        view.contentInsetAdjustmentBehavior = .never
        return view
    }()
    
    var viewModel: BaseContentViewModel?
    
    init(viewModel: BaseContentViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModels()
    }
}

extension BaseContentViewController {
    private func setupViews() {
        setupNavigationBar()
        setupSearchTextField()
        setupTableView()
    }

    private func setupNavigationBar() {
        navigationBarView.viewModel = viewModel?.navigationViewModel
        view.addSubview(navigationBarView)
        NSLayoutConstraint.activate([
            navigationBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        navigationBarView.title = "Search"
    }

    private func setupSearchTextField() {
        view.addSubview(searchTextField)
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor, constant: UIConstants.Padding.small),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.Padding.medium),
            searchTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setupTableView() {
        view.addSubview(contentTableView)
        NSLayoutConstraint.activate([
            contentTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: UIConstants.Padding.small),
            contentTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension BaseContentViewController {
    func bindViewModels() {
        viewModel?.shownNews.bind { [weak self] _ in
            self?.contentTableView.reloadData()
        }
        viewModel?.user.bindAndFire(listener: { [weak self] in
            self?.navigationBarView.avatarImageView.title = $0?.username?.last?.uppercased() ?? ""
        })
    }
}

extension BaseContentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.contentTableViewNumberOfRowsInSection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kNewsItemTableViewCell, for: indexPath)
        if let newsCell = cell as? NewsItemTableViewCell {
            newsCell.viewModel = viewModel?.contentTableViewCellViewModel(at: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel?.contentTableViewHeightForRows(at: indexPath) ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.navigateToNewsDetails(at: indexPath)
    }
}
