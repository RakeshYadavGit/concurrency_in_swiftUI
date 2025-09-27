//
//  CurrentDate.swift
//  ConcurrencyInSwift
//
//  Created by Rakesh Yadav on 27/09/25.
//

import Foundation

struct CurrentDate: Decodable, Identifiable {
    let id: UUID = UUID()
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case date = "formatted"
    }
}

