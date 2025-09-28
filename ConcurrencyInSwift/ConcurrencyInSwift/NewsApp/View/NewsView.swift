//
//  NewsView.swift
//  ConcurrencyInSwift
//
//  Created by Rakesh Yadav on 28/09/25.
//

import SwiftUI

struct NewsView: View {
    
    @StateObject private var newsViewModel = NewsViewModel()
    
    var body: some View {
        NavigationStack {
            List(newsViewModel.newsSources, id: \.id) { source in
                NavigationLink(
                    destination: NewsArticleView(id: source.id, title: source.name)
                ) {
                    NewsSourceCell(title: source.name, description: source.description)
                }
            }
            .listStyle(.plain)
            .navigationTitle("News Sources")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Task {
                            await self.newsViewModel.getSources()
                        }
                        
                    } label: {
                        Image(systemName: "arrow.clockwise.circle")
                    }
                }
            }
            .task {
                await self.newsViewModel.getSources()
            }
        }
    }
}

struct NewsSourceCell: View {
    
    let title: String
    let description: String
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
            Text(description)
        }
    }
}
