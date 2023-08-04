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
    let game_type: String?
    let conference_game: Bool?
    let venue: Venue
    let home: TrimmedTeam
    let away: TrimmedTeam
    let broadcast: BroadCast?
    
    func getScheduledDate() -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        inputFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let dateSplit = scheduled.split(separator: "+")
        let dateString = dateSplit[0]
        let date = inputFormatter.date(from: String(dateString))
        
        if let date = date {
            var calendar = Calendar(identifier: .iso8601)
            calendar.timeZone = .current
            let components = calendar.dateComponents([.year, .day, .month, .hour, .minute], from: date)
            
            if let month = components.month,
               let day = components.day,
               let hour = components.hour,
               let minute = components.minute {
                let trueHour = (hour % 12) == 0 ? 12 : hour % 12
                return String(format: "%d:%02d\n%d/%d ", trueHour, minute, month, day)
            }
        }
        return ""
    }
}

struct TrimmedTeam: Codable {
    let id: String
    let name: String
    let alias: String
    let game_number: Int?
    let sr_id: String
    
    
}
