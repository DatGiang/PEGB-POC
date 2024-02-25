//
//  Log.swift
//  PEGBCore
//
//  Created by Dat Giang on 25/02/2024.
//

import Foundation

public func printLog(_ data: Any) {
    #if DEBUG
    print(data)
    #endif
}
