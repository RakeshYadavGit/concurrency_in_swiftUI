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
    
    func fetchNewsWithAsync(by sourceId: String, url: URL?) async throws -> [NewsArticle] {
       try await withUnsafeThrowingContinuation { continuation in
            self.fetchNews(by: sourceId, url: url) { result in
                switch result {
                case .success(let newsArticles):
                    continuation.resume(returning: newsArticles)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func fetchNews(by sourceId: String, url: URL?, completion: @escaping (Result<[NewsArticle], NetworkError>) -> Void) {
        
        guard let url = url else {
            completion(.failure(.badUrl))
            return
        }
            
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let newsArticleResponse = try JSONDecoder().decode(NewsArticleResponse.self, from: data)
                completion(.success(newsArticleResponse.articles ?? []))
            } catch {
                completion(.failure(.invalidData))
                
                print(error)
            }
            
            
        }.resume()
        
    }
}
