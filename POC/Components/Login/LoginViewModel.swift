//
//  LoginViewModel.swift
//  poc
//
//  Created by Dat Giang on 23/02/2024.
//

import Foundation
import PEGBCore
import PEGBUseCases

class LoginViewModel: NSObject, ViewModel {
    let mainViewControllerNavigatable = Dynamic<Bool>(false)
    var mainTabViewModel: MainTabViewModel!
    
    func login(username: String, password: String) {
        UserAuthenticationUseCase().login(username: username, password: password) {
            switch $0 {
            case let .failure(error):
                mainTabViewModel = MainTabViewModel()
                mainViewControllerNavigatable.value = true
            case .success:
                mainTabViewModel = MainTabViewModel()
                mainViewControllerNavigatable.value = true
            }
        }
    }
}
