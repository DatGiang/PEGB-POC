//
//  PEGBUINavigationBar.swift
//  PEGBUIKit
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import PEGBUIKit
import UIKit

class PEGBUINavigationBar: HorizontalViews {
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
}

extension PEGBUINavigationBar {
    private func setupViews() {
        setupAvatarView()
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
}
