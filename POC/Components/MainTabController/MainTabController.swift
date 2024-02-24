//
//  MainTabController.swift
//  POC
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import UIKit

class MainTabController: UITabBarController {
    private enum TabItems: Int, CaseIterable {
        case topHeadlines
        case savedNews
        
        var viewController: UIViewController {
            switch self {
            case .topHeadlines:
                return TopHeadlinesViewController()
            case .savedNews:
                return SavedNewsViewController()
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
    
    private lazy var navigationBarView: PEGBUINavigationBar = {
       let view = PEGBUINavigationBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViewControllers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationController?.isNavigationBarHidden = true
        tabBarController?.navigationController?.navigationBar.isHidden = true
    }
}

extension MainTabController {
    private func setupViewControllers() {
        viewControllers = TabItems.allCases.map { $0.viewController }
        for (index, item) in TabItems.allCases.enumerated() {
            viewControllers?[index].tabBarItem.title = item.title
            viewControllers?[index].tabBarItem.image = item.icon
        }
    }
}
