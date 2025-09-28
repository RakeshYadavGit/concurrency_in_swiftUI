//
//  AppConstants.swift
//  ConcurrencyInSwift
//
//  Created by Rakesh Yadav on 28/09/25.
//

import Foundation

struct AppConstants {
    static let newsAPIKey: String = "86cd9cb9396e423c8a8af8f2cdcaaa7b"
    static let newsAPIbaseUrl: String = "https://newsapi.org/v2"
    static let newsAPISource: URL? = URL(string: "\(newsAPIbaseUrl)/sources?apiKey=\(newsAPIKey)")
    
    static func topHeadlines(by source: String) -> URL? {
        return URL(string: "\(newsAPIbaseUrl)/top-headlines?sources=\(source)&apiKey=\(newsAPIKey)")
    }
}

enum NetworkError: Error {
    case badUrl
    case invalidData
    case decodingError
}
