//
//  SavedNewsViewModel.swift
//  POC
//
//  Created by Dat Giang on 24/02/2024.
//

import Foundation
import PEGBUseCases
import UIKit

class SavedNewsViewModel: BaseContentViewModel {
    override func bindShowNews() {
        self.shownNews.value = self.allNews.value.filter { $0.1 }
    }
}
