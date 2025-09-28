//
//  NewsSource.swift
//  ConcurrencyInSwift
//
//  Created by Rakesh Yadav on 28/09/25.
//

import Foundation

struct NewsSourceResponse: Decodable {
    let sources: [NewsSource]
}

struct NewsSource: Decodable {
    let id: String
    let name: String
    let description: String
}
