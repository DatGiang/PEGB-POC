//
//  MainTabController.swift
//  POC
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import PEGBCore
import UIKit

class MainTabController: UITabBarController, View {
    private enum TabItems: Int, CaseIterable {
        case topHeadlines
        case savedNews

        func getViewController(parent: MainTabController) -> UIViewController {
            switch self {
            case .topHeadlines:
                return TopHeadlinesViewController(viewModel: parent.viewModel?.baseContentViewModel)
            case .savedNews:
                return SavedNewsViewController(viewModel: parent.viewModel?.baseContentViewModel)
            }
        }

        var title: String {
            switch self {
            case .topHeadlines:
                return "Top Headlines"
            case .savedNews:
                return "Saved News"
            }
        }

        var icon: UIImage {
            switch self {
            case .topHeadlines:
                return UIImage(named: "globe") ?? .init()
            case .savedNews:
                return UIImage(named: "bookmark.fill") ?? .init()
            }
        }
    }
    
    var viewModel: MainTabViewModel?
    
    init(viewModel: MainTabViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViewControllers()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationController?.isNavigationBarHidden = true
        tabBarController?.navigationController?.navigationBar.isHidden = true
    }
}

extension MainTabController {
    private func setupViewControllers() {
        viewControllers = TabItems.allCases.map { $0.getViewController(parent: self) }
        for (index, item) in TabItems.allCases.enumerated() {
            viewControllers?[index].tabBarItem.title = item.title
            viewControllers?[index].tabBarItem.image = item.icon
        }
    }
}

extension MainTabController {
    private func bindViewModel() {
        viewModel?.isLogout.bind { [weak self] in
            if $0 { self?.navigationController?.popViewController(animated: true) }
        }
        viewModel?.newsDetailsNavigatable.bind { [weak self] in
            if $0 {
                guard let self, let newsDetailsViewModel = self.viewModel?.newsDetailsViewModel else { return }
                let newsDetailsViewController: NewsDetailsViewController = .init(viewModel: newsDetailsViewModel)
                self.navigationController?.pushViewController(newsDetailsViewController, animated: true)
            }
        }
    }
}
