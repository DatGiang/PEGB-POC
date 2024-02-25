//
//  NewsResourceHelper.swift
//  PEGBUseCases
//
//  Created by Dat Giang on 25/02/2024.
//

import Foundation
import Networking

struct NewsResourceHelper {
    private let network: Network<NewsResource> = .init()
    
    func getTopHeadlines(completion: @escaping ((Result<[NewsResponse], Error>) -> Void)) {
        network.sendAndGetResponse(.topHeadlines) { (result: Result<(BaseResponse<[NewsResponse]>, HTTPURLResponse), Error>) in
            switch result {
            case let .success(response):
                completion(.success(response.0.articles ?? []))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
