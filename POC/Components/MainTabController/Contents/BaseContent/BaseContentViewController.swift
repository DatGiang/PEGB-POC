//
//  BaseContentViewController.swift
//  POC
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import PEGBUIKit
import UIKit

class BaseContentViewController: BaseViewController {
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

    override func loadView() {
        super.loadView()
        setupViews()
    }
}

extension BaseContentViewController {
    private func setupViews() {
        setupNavigationBar()
        setupSearchTextField()
        setupTableView()
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

    private func setupSearchTextField() {
        view.addSubview(searchTextField)
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor, constant: UIConstants.Padding.small),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.Padding.medium),
            searchTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        navigationBarView.avatarImageView.title = "A"
        navigationBarView.title = "Search"
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

extension BaseContentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kNewsItemTableViewCell, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        144
    }
}
