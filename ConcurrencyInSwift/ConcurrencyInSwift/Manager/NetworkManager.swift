//
//  NetworkManager.swift
//  ConcurrencyInSwift
//
//  Created by Rakesh Yadav on 28/09/25.
//

import Foundation

class NetworkManager {
    
    static let shared: NetworkManager = .init()
    
    private init() {}
    
    func fetchSource(url: URL?) async throws -> [NewsSource] {
        guard let url = url else { return [] }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let newsRes: NewsSourceResponse? = try? JSONDecoder().decode(NewsSourceResponse.self, from: data)
        return newsRes?.sources ?? []
    }
    
    func fetchNews(by sourceId: String, url: URL?) async throws -> [NewsArticle] {
        guard let url = url else { return []}
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let newsArticleResponse: NewsArticleResponse? = try? JSONDecoder().decode(NewsArticleResponse.self, from: data)
        
        return newsArticleResponse?.articles ?? []
    }
}
