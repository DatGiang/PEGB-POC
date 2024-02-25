//
//  NewsRequesterUseCase.swift
//  PEGBUseCases
//
//  Created by Dat Giang on 25/02/2024.
//

import Foundation

public typealias NewsResponseResult = (Result<[NewsResponse], Error>) -> Void

public struct NewsRequesterUseCase {
    public init() {}
    public func getTopHeadlines(completion: @escaping NewsResponseResult) {
        NewsResourceHelper().getTopHeadlines(completion: completion)
    }
}
