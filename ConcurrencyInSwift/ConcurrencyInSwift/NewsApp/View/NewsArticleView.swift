//
//  NewsArticleView.swift
//  ConcurrencyInSwift
//
//  Created by Rakesh Yadav on 28/09/25.
//

import SwiftUI

struct NewsArticleView: View {
    
    @StateObject var newsArticleViewModel: NewsArticleViewModel = .init()
    
    let id: String
    let title: String
    
    init(id: String, title: String) {
        self.id = id
        self.title = title
    }
    
    var body: some View {
        NavigationStack {
            List(newsArticleViewModel.newsArticles, id: \.id) { newsArticle in
                NewsArticleCell(newsArticle: newsArticle)
            }
            .listStyle(.plain)
            .task {
                await newsArticleViewModel.getNewsBy(sourceId: id)
            }
            .navigationTitle(title)
        }
    }
}


struct NewsArticleCell: View {
    
    let newsArticle: NewsArticle
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            
            // Async image
            if let imageUrl = newsArticle.urlToImage,
               let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipped()
                        .cornerRadius(8)
                } placeholder: {
                    ProgressView()
                        .frame(width: 100, height: 100)
                }
            }
            
            // Article text
            VStack(alignment: .leading, spacing: 6) {
                Text(newsArticle.title)
                    .font(.headline)
                    .lineLimit(2)
                
                if let description = newsArticle.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                }
            }
        }
        .padding(.vertical, 8)
    }
}
