//
//  AppDelegate.swift
//  POC
//
//  Created by Dat Giang on 23/02/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let loginViewController: LoginViewController = .init(viewModel: LoginViewModel())
        let rootNavigationController: UINavigationController = .init(rootViewController: loginViewController)
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
        return true
    }
}

