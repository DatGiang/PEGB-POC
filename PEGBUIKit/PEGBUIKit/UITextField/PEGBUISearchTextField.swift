//
//  PEGBUISearchTextField.swift
//  PEGBUIKit
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import UIKit

public class PEGBUISearchTextField: UIView {
    public var placeholder: String? {
        get { return searchTextField.placeholder }
        set {
            let string = newValue ?? ""
            searchTextField.placeholder = string
        }
    }
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 8
        return view
    }()

    private lazy var searchTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Search"
        textfield.returnKeyType = .search
        return textfield
    }()
    
    private lazy var iconSearchImageView: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage(named: "magnifyingglass")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return view
    }()


    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
}

extension PEGBUISearchTextField {
    private func setupViews() {
        roundCorner()
        border(color: .primary)
        heightAnchor.constraint(equalToConstant: UIConstants.Sizes.textFieldHeight).isActive = true
        
        setupStackView()
        setupImageSearch()
        setupSearchTextField()
    }

    private func setupSearchBarBackgroundView() {
        
    }
    
    private func setupStackView() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.Padding.small),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    private func setupSearchTextField() {
        stackView.addArrangedSubview(searchTextField)
    }
    
    private func setupImageSearch() {
        stackView.addArrangedSubview(iconSearchImageView)
        
        NSLayoutConstraint.activate([
            iconSearchImageView.heightAnchor.constraint(equalToConstant: UIConstants.Sizes.iconSize.height),
            iconSearchImageView.widthAnchor.constraint(equalTo: iconSearchImageView.heightAnchor)
        ])
    }
}
