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
    
    func fetchSources(url: URL?, completion: @escaping (Result<[NewsSource], NetworkError>) -> Void) {
        
        guard let url = url else {
            completion(.failure(.badUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            let newsSourceResponse = try? JSONDecoder().decode(NewsSourceResponse.self, from: data)
            completion(.success(newsSourceResponse?.sources ?? []))
            
        }.resume()
        
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
