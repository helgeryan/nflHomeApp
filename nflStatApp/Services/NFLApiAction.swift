//
//  NFLApiAction.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/2/23.
//

import Foundation
import Alamofire

enum NFLApiAction {
    case draft(year: Int)
    case leagueLeaders(year: Int)
    case schedule(year: Int)
    case heirarchy
    case teamRoster(teamId: String)
    case dailyTransactions(date: Date)
    case playerProfile(playerId: String)
}

extension NFLApiAction: NFLRouter {
    var mockDataFileName: String {
        switch self {
        case .draft:
            return "MockDraftResponse"
        case .leagueLeaders:
            return "MockStats"
        case .schedule:
            return "MockStats"
        case .heirarchy:
            return "MockHeirarchy"
        case .teamRoster:
            return "MockTeamRoster"
        case .dailyTransactions:
            return "MockDailyTransactions"
        case .playerProfile:
            return "MockPlayerProfile"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .draft :
            return .get
        case .leagueLeaders:
            return .get
        case .schedule:
            return .get
        case .heirarchy:
            return .get
        case .teamRoster:
            return .get
        case .dailyTransactions:
            return .get
        case .playerProfile:
            return .get
        }
    }

    var path: String {
        switch self {
        case .draft(let year) :
            return "draft/nfl/trial/v1/en/\(year)/draft.json?api_key=eegavg9txm5q62k8r3zrkpxm"
        case .leagueLeaders(let year):
            return "trial/v8/en/seasons/\(year)/REG/leaders.json?api_key=eegavg9txm5q62k8r3zrkpxm"
        case .schedule(let year):
            return "trial/v7/en/games/\(year)/REG/schedule.json?api_key=eegavg9txm5q62k8r3zrkpxm"
        case .heirarchy:
            return "trial/v7/en/league/hierarchy.json?api_key=eegavg9txm5q62k8r3zrkpxm"
        case.teamRoster(let teamId):
            return "trial/v7/en/teams/\(teamId)/full_roster.json?api_key=eegavg9txm5q62k8r3zrkpxm"
        case .dailyTransactions(let date):
            let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
            return "trial/v7/en/league/\(components.year!)/\(components.month!)/\(components.day!))/transactions.json?api_key=eegavg9txm5q62k8r3zrkpxm"
        case .playerProfile(let id):
            return "trial/v7/en/players/\(id)/profile.json?api_key=eegavg9txm5q62k8r3zrkpxm"
        }
    }
    
    var baseUrl: String {
        switch self {
        case .draft:
            return "https://api.sportradar.us/"
        case .leagueLeaders,
                .schedule,
                .heirarchy,
                .teamRoster,
                .dailyTransactions,
                .playerProfile:
            return "https://api.sportradar.us/nfl/official/"
        }
    }
    
    var parameters: [String : Any] {
        return [:]
    }
    
    var authHeader: Alamofire.HTTPHeaders? {
        return nil
    }
    
    var parameterEncoding: Alamofire.ParameterEncoding {
        return URLEncoding.default
    }
}
