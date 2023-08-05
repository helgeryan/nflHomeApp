//
//  HomeViewModel.swift
//  nflStatApp
//
//  Created by Ryan Helgeson on 8/5/23.
//

import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    @Published var transactions: [Transcation] = []
    
    init() {
        Task {
            if let transactionResponse = await NFLService().getDailyTransactions(date: Date()) {
                var transactionArray:[Transcation] = []
                for player in transactionResponse.players {
                    if let trans = player.transactions {
                        transactionArray.append(contentsOf: trans)
                    }
                }
                self.transactions = transactionArray
            }
        }
    }
}
