//
//  UIImageView+Extension.swift
//  PEGBUIKit
//
//  Created by Dat Giang on 25/02/2024.
//

import Foundation
import UIKit

extension UIImageView {
    public func setHightlightColor(_ hightlightColor: UIColor) {
        guard let image = image else {
            return
        }
        self.image = image.withRenderingMode(.alwaysTemplate)
        tintColor = hightlightColor
    }
}
