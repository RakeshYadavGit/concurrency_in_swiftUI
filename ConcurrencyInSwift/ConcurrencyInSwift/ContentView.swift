//
//  ContentView.swift
//  ConcurrencyInSwift
//
//  Created by Rakesh Yadav on 27/09/25.
//

import SwiftUI

struct ContentView: View {
    
    let imageUrl: URL = URL(string: "https://picsum.photos/200/300")!
    
    var body: some View {
        VStack {
            List(0...100, id: \.self) { item in
                Text("\(item)")
            }
            
            Button("Download Image URL") {
                self.downloadImage()
            }
        }
        .padding()
    }
    
    func downloadImage() {
        DispatchQueue.global(qos: .background).async {
            let _ = try? Data(contentsOf: imageUrl)
        }
        
    }
}

#Preview {
    ContentView()
}
