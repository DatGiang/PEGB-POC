//
//  NewsResponse.swift
//  PEGBUseCases
//
//  Created by Dat Giang on 25/02/2024.
//

import Foundation

// MARK: - Article
public struct NewsResponse: Decodable {
    let source: Source?
    public let author: String?
    public let title: String?
    let description: String?
    public let url: String?
    public let urlToImage: String?
    public let publishedAt: String?
    public let content: String?
    
    public init(author: String?, title: String?, url: String?, urlToImage: String?, publishedAt: String?, content: String?) {
        self.source = nil
        self.description = nil
        self.author = author
        self.title = title
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}

// MARK: - Source
struct Source: Decodable {
    let id: String?
    let name: String?
}
