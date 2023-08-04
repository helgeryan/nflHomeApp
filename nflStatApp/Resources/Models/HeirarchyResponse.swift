//
//  HeirarchyResponse.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import Foundation

struct HeirarchyResponse: Codable {
    let league: League
    let conferences: [Conference]
}

struct Conference: Codable {
    let id: String
    let name: String
    let alias: String
    let divisions: [Division]?
}

struct Division: Codable {
    let id: String
    let name: String
    let alias: String
    let teams: [Team]?
}

struct TeamColor: Codable {
    let type: String
    let hex_color: String
    let rgb_color: RGBColor
}

struct RGBColor: Codable {
    let red: Int
    let green: Int
    let blue: Int
}

