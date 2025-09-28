//
//  NewsViewModel.swift
//  ConcurrencyInSwift
//
//  Created by Rakesh Yadav on 28/09/25.
//

import Foundation

class NewsViewModel: ObservableObject {
    
    @Published var newsSources: [NewsSource] = []
    
    func getSources() {
        
        NetworkManager.shared.fetchSources(url: AppConstants.newsAPISource) { result in
            switch result {
                case .success(let newsSources):
                    DispatchQueue.main.async {
                        self.newsSources = newsSources
                    }
                case .failure(let error):
                    print(error)
            }
        }
        
    }
}
