//
//  PEGBUICircleImageView.swift
//  PEGBUIKit
//
//  Created by Dat Giang on 23/02/2024.
//

import Foundation
import UIKit

public class PEGBUICircleImageView: UIImageView {
    override public init(image: UIImage?) {
        super.init(image: image, highlightedImage: nil)
        setupViews()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    override public func layoutSubviews() {
        layer.cornerRadius = frame.size.width / 2
        clipsToBounds = true
    }
}

extension PEGBUICircleImageView {
    private func setupViews() {
        contentMode = .scaleAspectFill
        border(color: .primary)
    }
}
