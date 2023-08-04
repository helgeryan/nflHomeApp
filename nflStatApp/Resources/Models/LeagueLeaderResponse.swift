//
//  LeagueLeaderResponse.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/2/23.
//

import Foundation

struct LeagueLeadersResponse: Codable {
    let season: Season
    let id: String
    let name: String
    let alias: String
    let type: String
    let categories: [StatCategory]
}

struct Season: Codable {
    let id: String
    let year: Int
    let type: String
}

struct StatCategory: Codable {
    let name: String
    let type: String
    let ranks: [Rank]
    
    var id: String {
        return "\(name)_\(type)"
    }
    
    var cleanName: String {
        var clearString = name.replacingOccurrences(of: "_", with: " ")
        return clearString.capitalized
    }
}

struct Rank: Codable {
    let rank: Int
    let tied: Bool
    let score: Double
    let player: Player
    let teams: [Team]
    let total: TotalStatList
    let average: AverageStatList
}

struct TotalStatList: Codable {
    
}

struct AverageStatList: Codable {
    
}
