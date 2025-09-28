//
//  NewsArticleViewModel.swift
//  ConcurrencyInSwift
//
//  Created by Rakesh Yadav on 28/09/25.
//

import Foundation

class NewsArticleViewModel: ObservableObject {
    @Published var newsArticles = [NewsArticle]()
    
    func getNewsBy(sourceId: String) {
        
        NetworkManager.shared.fetchNews(by: sourceId, url: AppConstants.topHeadlines(by: sourceId)) { result in
            switch result {
                case .success(let newsArticles):
                    DispatchQueue.main.async {
                        self.newsArticles = newsArticles
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
}
