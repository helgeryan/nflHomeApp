//
//  FreeAgentResponse.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import Foundation

struct ScheduleResponse: Codable {
    let id: String
    let year: Int
    let type: String
    let name: String
    let weeks: [Week]
}

struct Week: Codable {
    let id: String
    let sequence: Int
    let title: String
    let games: [Game]
}

struct Game: Codable {
    let id: String
    let status: String
    let scheduled: String
    let entry_mode: String
    let sr_id: String
    let game_type: String
    let conference_game: Bool
    let venue: Venue
    let home: TrimmedTeam
    let away: TrimmedTeam
    let broadcast: BroadCast?
}

struct TrimmedTeam: Codable {
    let id: String
    let name: String
    let alias: String
    let game_number: Int
    let sr_id: String
    
    
}
