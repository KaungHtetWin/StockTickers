//
//  NewsModel.swift
//  StockTickers
//
//  Created by MgKaung on 13/06/2022.
//

import Foundation
// MARK: - News
struct News: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    var source: Source?
    var author, title, articleDescription: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: Date?
    var content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}
// MARK: - Source
struct Source: Codable {
    var id, name: String?
}
