//
//  DraftResponse.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import Foundation

struct Draft: Codable {
    let id: String
    let year: Int
    let start_date: String
    let end_date: String
    let status: String
    let league: League
    let broadcast: BroadCast
    let venue: Venue
}

struct League: Codable {
    let id: String
    let name: String
    let alias: String
}

struct BroadCast: Codable {
    let channel: String?
    let network: String
}

struct Venue: Codable {
    let name: String
    let address: String
    let city: String
    let state: String?
    let country: String
    let sr_id: String?
    let location: Location?
}

struct Location: Codable {
    let lat: String
    let lng: String
}

struct DraftResponse: Codable {
    let draft: Draft
    let rounds: [Round]
}

struct Round: Codable {
    let id: String
    let number: Int
    let start_date: String
    let end_date: String
    let status: String
    let picks: [Pick]
}

struct Pick: Codable {
    let id: String
    let number: Int
    let overall: Int
    let team: Team
    let prospect: Player
}


struct Team: Codable {
    let id: String
    let name: String
    let market: String
    let alias: String?
    let sr_id: String?
    let reference: String?
    let team_colors: [TeamColor]?
    let players: [Player]?
    let coaches: [Coach]?
    let conference: Conference?
    let division: Division?
    let venue: Venue?
    
    func getRosterSorted() -> [Player] {
        if let players = players {
            return players.sorted(by: {
                return $0.intJersey < $1.intJersey
            })
        }
        else {
            return []
        }
    }
    
    static let teamNames: [String] = [
        "Packers",
        "Lions",
        "Vikings",
        "Bears",
        "49ers",
        "Chiefs",
        "Chargers",
        "Rams",
        "Commanders",
        "Seahawks",
        "Cardinals",
        "Eagles",
        "Giants",
        "Cowboys",
        "Saints",
        "Buccaneers",
        "Panthers",
        "Falcons",
        "Raiders",
        "Broncos",
        "Steelers",
        "Ravens",
        "Bengals",
        "Browns",
        "Titans",
        "Texans",
        "Colts",
        "Jaguars",
        "Bills",
        "Jets",
        "Dolphins",
        "Patriots"
    ]
}

struct Player: Codable {
    let id: String
    let status: String?
    let abbr_name: String?
    let primary_position: String?
    let source_id: String?
    let league_id: String?
    let first_name: String
    let last_name: String
    let name: String?
    let full_name: String?
    let position: String
    let team_name: String?
    let height: Int?
    let weight: Int?
    let college: String?
    let birth_place: String?
    let birthdate: String?
    let jersey: String?
    let top_prospect: Bool?
    let updated: String?
    let rookie_year: Int?
    let transactions: [Transcation]?
    
    func getName() -> String {
        return name ?? full_name ?? (first_name + " " + last_name)
    }
    
    var heightInches: Int? {
        if let height = height {
            return height % 12
        }
        return nil
    }
    
    var heightFeet: Int? {
        if let height = height {
            return Int(floor(Double(height) / 12.0))
        }
        return nil
    }
    
    var intJersey: Int {
        if let jString = jersey {
            return Int(jString) ?? 100
        } else {
            return 100
        }
    }
    
    static func filterForPositionGroup(players: [Player], filterParams: [String]) -> [Player] {
        let filteredPlayers: [Player] = players.filter({ return filterParams.contains($0.position)
        })
        return filteredPlayers
    }
}

struct Coach: Codable {
    let id: String
    let full_name: String
    let first_name: String
    let last_name: String
    let position: String
    let experience: Int?
    let referenece: String?
}
