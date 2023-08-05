//
//  TransactionResponse.swift
//  nflStatApp
//
//  Created by Ryan Helgeson on 8/5/23.
//

import Foundation

struct DailyTransactionResponse: Codable {
    let league: League
    let players: [Player]
}


struct Transcation: Codable {
    let id: String
    let desc: String
    let effective_date: String
    let last_modified: String
    let transaction_type: String
    let transaction_year: Int
    let status_before: String
    let status_after: String
    let to_team: Team?
    let from_team: Team?
}
