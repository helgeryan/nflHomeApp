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
    let name: String
    let teams: [TeamSeasonStats]?
}

struct TeamSeasonStats: Codable {
    let id: String
    let name: String
    let market: String
    let alias: String
    let statistics: Statistics
}

struct Statistics: Codable {
    let games_played: Int
    let games_started: Int
    let rushing: RushingStats?
    let receiving: ReceivingStats?
    let passing: PassingStats?
}

struct RushingStats: Codable {
    let avg_yards: Double
    let attempts: Int
    let touchdowns: Int
    let yards: Int
    let longest: Int
    let longest_touchdown: Int
    let redzone_attempts: Int
    let tlost: Int
    let tlost_yards: Int
    let first_downs: Int
    let broken_tackles: Int
    let kneel_downs: Int
    let scrambles: Int
    let yards_after_contact: Int
}
            

struct ReceivingStats: Codable {
    let receptions: Int
    let targets: Int
    let yards: Int
    let avg_yards: Double
    let longest: Int
    let touchdowns: Int
    let longest_touchdown: Int
    let yards_after_catch: Int
    let redzone_targets: Int
    let air_yards: Int
    let first_downs: Int
    let broken_tackles: Int
    let dropped_passes: Int
    let catchable_passes: Int
    let yards_after_contact: Int
}

struct PassingStats: Codable {
    let attempts: Int
    let completions: Int
    let cmp_pct: Double
    let yards: Int
    let avg_yards: Double
    let sacks: Int
    let sack_yards: Int
    let touchdowns: Int
    let longest: Int
    let interceptions: Int
    let longest_touchdown: Int
    let air_yards: Int
    let rating: Double
    let redzone_attempts: Int
    let gross_yards: Int
    let first_downs: Int
    let throw_aways: Int
    let poor_throws: Int
    let defended_passes: Int
    let dropped_passes: Int
    let spikes: Int
    let blitzes: Int
    let hurries: Int
    let knockdowns: Int
    let pocket_time: Double
    let avg_pocket_time: Double
    let net_yards: Int
    let batted_passes: Int
    let on_target_throws: Int
}

struct StatCategory: Codable {
    let name: String
    let type: String
    let ranks: [Rank]
    
    var id: String {
        return "\(name)_\(type)"
    }
    
    var cleanName: String {
        return name.replacingOccurrences(of: "_", with: " ").capitalized
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
