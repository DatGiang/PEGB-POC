//
//  LoginViewController.swift
//  poc
//
//  Created by Dat Giang on 23/02/2024.
//

import Foundation
import PEGBUIKit
import UIKit
import PEGBCore

class LoginViewController: BaseViewController, View {
    private lazy var logoImageView: PEGBUICircleImageView = {
        let view = PEGBUICircleImageView(image: .init(named: "ic_logo"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var usernameTextField: PEGBUITextField = {
        let view = PEGBUITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Username"
        view.text = "usera"
        return view
    }()

    private lazy var passwordTextField: PEGBUITextField = {
        let view = PEGBUITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Password"
        view.isSecureTextEntry = true
        view.text = "passworda"
        return view
    }()

    private lazy var loginButton: PEGBUIButton = {
        let view = PEGBUIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.title = "Login"
        view.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        return view
    }()

    var viewModel: LoginViewModel?

    init(viewModel: LoginViewModel) {
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
        bindViewModel()
    }

    @objc private func didTapLogin() {
        viewModel?.login(username: usernameTextField.text, password: passwordTextField.text)
    }
}

extension LoginViewController {
    private func setupViews() {
        setupLogoImageView()
        setupUsernameTextField()
        setupPasswordTextField()
        setupLoginButton()
    }

    private func setupLogoImageView() {
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIConstants.Padding.large),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: UIConstants.Sizes.logoSize.height),
        ])
    }

    private func setupUsernameTextField() {
        view.addSubview(usernameTextField)
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: UIConstants.Padding.big),
            usernameTextField.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.Padding.medium),
        ])
    }

    private func setupPasswordTextField() {
        view.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: UIConstants.Padding.big),
            passwordTextField.centerXAnchor.constraint(equalTo: usernameTextField.centerXAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
        ])
    }

    private func setupLoginButton() {
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: UIConstants.Padding.extraLarge),
            loginButton.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor),
            loginButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
        ])
    }
}

extension LoginViewController {
    private func bindViewModel() {
        viewModel?.mainViewControllerNavigatable.bind { [weak self] in
            if $0 {
                self?.dismiss(animated: true)
            }
        }
    }
}
