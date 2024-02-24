//
//  PEGBUITextField.swift
//  PEGBUIKit
//
//  Created by Dat Giang on 23/02/2024.
//

import Foundation
import UIKit

public class PEGBUITextField: UIView {
    public var placeholder: String? {
        get { textField.placeholder }
        set {
            let string = newValue ?? ""
            textField.placeholder = string
        }
    }
    
    public var isSecureTextEntry: Bool {
        get { textField.isSecureTextEntry }
        set { textField.isSecureTextEntry = newValue }
    }
    
    public var text: String {
        get { textField.text ?? "" }
        set { textField.text = newValue }
    }
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.roundCorner()
        view.border(color: .primary)
        return view
    }()

    private lazy var textField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clearButtonMode = .whileEditing
        view.textAlignment = .center
        return view
    }()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
}

extension PEGBUITextField {
    private func setupViews() {
        setupBackgroundView()
        setupTextField()
    }

    private func setupBackgroundView() {
        addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: UIConstants.Sizes.textFieldHeight),
        ])
    }

    private func setupTextField() {
        backgroundView.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            textField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            textField.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
        ])
    }
}
