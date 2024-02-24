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
        let startables: [Startable] = [
            PredefineDataUseCase()
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

