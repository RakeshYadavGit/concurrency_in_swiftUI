//
//  NewsArticleViewModel.swift
//  ConcurrencyInSwift
//
//  Created by Rakesh Yadav on 28/09/25.
//

import Foundation

@MainActor
class NewsArticleViewModel: ObservableObject {
    @Published var newsArticles = [NewsArticle]()
    
    func getNewsBy(sourceId: String) async {
        
        do {
            self.newsArticles = try await NetworkManager.shared.fetchNews(by: sourceId, url: AppConstants.topHeadlines(by: sourceId))
        } catch {
            #warning("Handle this later")
        }
         
        
    }
}
