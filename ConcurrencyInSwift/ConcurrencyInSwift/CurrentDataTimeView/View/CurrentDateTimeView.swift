//
//  CurrentDateTimeView.swift
//  ConcurrencyInSwift
//
//  Created by Rakesh Yadav on 27/09/25.
//

import SwiftUI

struct CurrentDateTimeView: View {
    
    @StateObject var viewModel: CurrentDateTimeViewModel = .init()
    
    var body: some View {
        NavigationStack {
            List(self.viewModel.currentDates) { currentDate in
                Text(currentDate.date)
            }
            .listStyle(.plain)
            .navigationTitle("Dates")
            .navigationBarItems(trailing: Button(action: {
                Task {
                    await self.viewModel.populateDates()
                }
            }, label: {
                Image(systemName: "arrow.clockwise.circle")
            }))
            .task {
                await self.viewModel.populateDates()
            }
            .background(Color(.systemBackground))
        }
    }
}

#Preview {
    CurrentDateTimeView()
}
