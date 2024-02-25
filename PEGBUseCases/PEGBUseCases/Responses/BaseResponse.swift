//
//  BaseResponse.swift
//  PEGBUseCases
//
//  Created by Dat Giang on 25/02/2024.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
   let status: String?
   let totalResults: Int?
   let articles: T?
}
