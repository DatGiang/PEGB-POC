//
//  UIView+Extension.swift
//  PEGBUIKit
//
//  Created by Dat Giang on 23/02/2024.
//

import Foundation
import UIKit

extension UIView {
    func roundCorner(radius: CGFloat = 8) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }

    func border(width: CGFloat = 1, color: UIColor = .gray) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }

    func fade(_ value: Float, duration: CFTimeInterval = 0.08) {
        layer.removeAnimation(forKey: "FadeAnimation")
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.duration = duration
        animation.fromValue = layer.presentation()?.opacity
        layer.opacity = value
        animation.fillMode = CAMediaTimingFillMode.forwards
        layer.add(animation, forKey: "FadeAnimation")
    }
}
