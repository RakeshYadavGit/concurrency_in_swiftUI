//
//  NewsArticle.swift
//  ConcurrencyInSwift
//
//  Created by Rakesh Yadav on 28/09/25.
//

import Foundation

struct NewsArticleResponse: Decodable {
    let articles: [NewsArticle]
}

struct NewsArticle: Decodable, Identifiable {
    var id = UUID()
    let author: String?
    let title: String
    let description: String?
    let url: String?
    let content: String?
    let publishedAt: String
    let urlToImage: String?
    
    enum CodingKeys: CodingKey {
        case id
        case author
        case title
        case description
        case url
        case content
        case publishedAt
        case urlToImage
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
        self.publishedAt = try container.decode(String.self, forKey: .publishedAt)
        self.urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage)
    }
}
