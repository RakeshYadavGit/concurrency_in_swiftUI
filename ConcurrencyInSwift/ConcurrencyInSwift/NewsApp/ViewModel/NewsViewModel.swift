//
//  NewsViewModel.swift
//  ConcurrencyInSwift
//
//  Created by Rakesh Yadav on 28/09/25.
//

import Foundation

@MainActor
class NewsViewModel: ObservableObject {
    
    @Published var newsSources: [NewsSource] = []
    
    func getSources() async {
        
        do {
            self.newsSources = try await NetworkManager.shared.fetchSource(url: AppConstants.newsAPISource)
        } catch {
            #warning("handle this later")
        }
    }
}
