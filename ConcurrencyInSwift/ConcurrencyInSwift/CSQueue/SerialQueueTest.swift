//
//  SerialQueueTest.swift
//  ConcurrencyInSwift
//
//  Created by Rakesh Yadav on 27/09/25.
//

import Foundation

struct SerialQueueTest {
    
    private let serialQueue: DispatchQueue = DispatchQueue(label: "SerialQueue")
    
    func runTask() {
        self.serialQueue.async {
            debugPrint("1st Queue")
        }
        
        self.serialQueue.async {
            debugPrint("2st Queue")
        }
    }
}

