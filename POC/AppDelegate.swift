//
//  AppDelegate.swift
//  POC
//
//  Created by Dat Giang on 23/02/2024.
//

import UIKit
import PEGBUseCases
import PEGBCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    var newsDataSynchronizerListener: (() -> Void)?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        runStartable()
        setupMainView()
        return true
    }
}

extension AppDelegate {
    private func runStartable() {
        var newsDataSynchronizer: NewsDataSynchronizationUseCase = .init()
        newsDataSynchronizer.dataChangedListener = { [weak self] in
            self?.newsDataSynchronizerListener?()
        }
        let startables: [Startable] = [
            PredefineDataUseCase(),
            newsDataSynchronizer
        ]
        startables.forEach { $0.start() }
    }
    
    private func setupMainView() {
        let loginViewController: LoginViewController = .init(viewModel: LoginViewModel())
        let rootNavigationController: UINavigationController = .init(rootViewController: loginViewController)
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
    }
}

