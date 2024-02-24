//
//  UIImage+Extension.swift
//  POC
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import UIKit

extension UIImage {
    static func imageWithLabel(_ label: UILabel) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0)
        defer { UIGraphicsEndImageContext() }
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }
}
