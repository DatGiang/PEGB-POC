//
//  LoginViewController.swift
//  poc
//
//  Created by Dat Giang on 23/02/2024.
//

import Foundation
import PEGBUIKit
import UIKit

class LoginViewController: UIViewController {
    private lazy var logoImageView: PEGBUICircleImageView = {
        let view = PEGBUICircleImageView(image: .init(named: "ic_logo"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var usernameTextField: PEGBUITextField = {
        let view = PEGBUITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Username"
        return view
    }()

    private lazy var passwordTextField: PEGBUITextField = {
        let view = PEGBUITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Password"
        return view
    }()

    private lazy var loginButton: PEGBUIButton = {
        let view = PEGBUIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.title = "Login"
        return view
    }()

    override func loadView() {
        super.loadView()
        setupViews()
    }
}

extension LoginViewController {
    private func setupViews() {
        view.backgroundColor = .white
        setupLogoImageView()
        setupUsernameTextField()
        setupPasswordTextField()
        setupLoginButton()
    }

    private func setupLogoImageView() {
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIConstants.Padding.big),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    private func setupUsernameTextField() {
        view.addSubview(usernameTextField)
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: UIConstants.Padding.medium),
            usernameTextField.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.Padding.medium)
        ])
    }
    
    private func setupPasswordTextField() {
        view.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: UIConstants.Padding.medium),
            passwordTextField.centerXAnchor.constraint(equalTo: usernameTextField.centerXAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor)
        ])
    }
    
    private func setupLoginButton() {
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: UIConstants.Padding.medium),
            loginButton.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor),
            loginButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor)
        ])
    }
}
