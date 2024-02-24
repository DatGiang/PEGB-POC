//
//  BaseViewController.swift
//  POC
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
    }
}
