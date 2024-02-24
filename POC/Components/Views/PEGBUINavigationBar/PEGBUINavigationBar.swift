//
//  PEGBUINavigationBar.swift
//  PEGBUIKit
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import PEGBCore
import PEGBUIKit
import UIKit

class PEGBUINavigationBar: HorizontalViews, View {
    var title: String {
        get { return titleLabel.text ?? "" }
        set {
            let string = newValue
            titleLabel.text = string
        }
    }

    lazy var avatarImageView: PEGBAvatarView = {
        let view = PEGBAvatarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var logoutButton: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage(named: "rectangle.portrait.and.arrow.forward")?.withRenderingMode(.alwaysOriginal), for: .normal)
        view.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
        return view
    }()
    
    var viewModel: PEGBUINavigationBarViewModel?
    
    init(viewModel: PEGBUINavigationBarViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    @objc private func didTapLogout() { viewModel?.didTapLogout() }
}

extension PEGBUINavigationBar {
    private func setupViews() {
        setupAvatarView()
        setupLogoutButton()
    }

    private func setupAvatarView() {
        let avatarView = UIView()
        avatarView.translatesAutoresizingMaskIntoConstraints = false

        avatarView.addSubview(avatarImageView)
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: avatarView.topAnchor, constant: UIConstants.Padding.small),
            avatarImageView.leadingAnchor.constraint(equalTo: avatarView.leadingAnchor, constant: UIConstants.Padding.small),
            avatarImageView.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: UIConstants.Sizes.avatarSize.height),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
        ])

        addSubLeadingView(avatarView)
    }

    private func setupLogoutButton() {
        let logoutView = UIView()
        logoutView.translatesAutoresizingMaskIntoConstraints = false

        logoutView.addSubview(logoutButton)
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: logoutView.topAnchor, constant: UIConstants.Padding.small),
            logoutButton.leadingAnchor.constraint(equalTo: logoutView.leadingAnchor, constant: UIConstants.Padding.small),
            logoutButton.centerXAnchor.constraint(equalTo: logoutView.centerXAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: logoutView.centerYAnchor),
            logoutButton.heightAnchor.constraint(equalToConstant: UIConstants.Sizes.iconSize.height),
            logoutButton.heightAnchor.constraint(equalTo: logoutButton.widthAnchor),
        ])

        addSubTrailingView(logoutView)
    }
}
