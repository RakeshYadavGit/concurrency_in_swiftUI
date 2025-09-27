//
//  CurrentDateTimeViewModel.swift
//  ConcurrencyInSwift
//
//  Created by Rakesh Yadav on 27/09/25.
//

import Foundation

class CurrentDateTimeViewModel: ObservableObject {
    
    @Published var currentDates: [CurrentDate] = []
    
    private func getCurrentDate() async throws -> CurrentDate? {
        let endPoint: String = "https://tools.aimylogic.com/api/now?tz=Asia/Kolkata&format=dd%20MMM%20yyyy%20hh:mm%20a"
        
        guard let endPointUrl: URL = URL(string: endPoint) else { return nil }
        
        let (data, _) = try await URLSession.shared.data(from: endPointUrl)
        
        return try? JSONDecoder().decode(CurrentDate.self, from: data)
    }
    
    @MainActor
    func populateDates() async {
        do {
            guard let currentDate: CurrentDate = try await self.getCurrentDate() else { return }
            self.currentDates.append(currentDate)
        } catch {
            return
        }
    }
    
}
