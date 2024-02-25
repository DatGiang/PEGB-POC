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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        runStartable()
        setupMainView()
        return true
    }
}

extension AppDelegate {
    private func runStartable() {
        var newsDataSynchronizer: NewsDataSynchronizationUseCase = .init()
        newsDataSynchronizer.dataChangedListener = { NotificationCenter.default.post(name: .NewsDataSynchronizerChanged, object: nil) }
        let startables: [Startable] = [
            PredefineDataUseCase(),
            newsDataSynchronizer
        ]
        startables.forEach { $0.start() }
    }
    
    private func setupMainView() {
        let mainViewController: MainTabController = MainTabController(viewModel: MainTabViewModel())
        let rootNavigationController: UINavigationController = .init(rootViewController: mainViewController)
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
        
        UserAuthenticationUseCase().getLoggedInUser {
            switch $0 {
            case .success:
                break
            case .failure:
                let login: LoginViewController = .init(viewModel: LoginViewModel())
                login.modalPresentationStyle = .fullScreen
                rootNavigationController.present(login, animated: true)
                break
            }
        }
    }
}

