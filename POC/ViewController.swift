//
//  ViewController.swift
//  POC
//
//  Created by Dat Giang on 23/02/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.pushViewController(MainTabController(), animated: true)
    }


}

