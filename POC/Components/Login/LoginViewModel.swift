//
//  LoginViewModel.swift
//  poc
//
//  Created by Dat Giang on 23/02/2024.
//

import Foundation
import PEGBCore

class LoginViewModel: NSObject, ViewModel {
    let mainViewControllerNavigatable = Dynamic<Bool>(false)
    var mainTabViewModel: MainTabViewModel!
    
    func login() {
        mainTabViewModel = MainTabViewModel()
        mainViewControllerNavigatable.value = true
    }
}
