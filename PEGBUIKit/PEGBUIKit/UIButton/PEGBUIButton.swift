//
//  PEGBUIButton.swift
//  PEGBUIKit
//
//  Created by Dat Giang on 23/02/2024.
//

import Foundation
import UIKit

public class PEGBUIButton: UIButton {
    public var title: String {
        get { titleLabel?.text ?? "" }
        set { setTitle(newValue) }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }

    override public var isHighlighted: Bool {
        didSet { isHighlighted ? fade(0.5) : fade(1.0) }
    }

    override public func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
    }

    public func setTitle(_ title: String) {
        setTitle(title, for: .normal)
    }

    public func setTitleColor(_ color: UIColor) {
        setTitleColor(color, for: .normal)
    }
}

extension PEGBUIButton {
    private func initViews() {
        roundCorner()
        backgroundColor = .primary
        heightAnchor.constraint(equalToConstant: UIConstants.Sizes.buttonHeight).isActive = true
    }
}
