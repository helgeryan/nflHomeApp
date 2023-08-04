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
    case freeAgents
    case heirarchy
    case teamRoster(teamId: String)
}

extension NFLApiAction: NFLRouter {
    var mockDataFileName: String {
        switch self {
        case .draft:
            return "MockDraftResponse"
        case .leagueLeaders:
            return "MockStats"
        case .freeAgents:
            return "MockFreeAgents"
        case .heirarchy:
            return "MockHeirarchy"
        case .teamRoster:
            return "MockTeamRoster"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .draft :
            return .get
        case .leagueLeaders:
            return .get
        case .freeAgents:
            return .get
        case .heirarchy:
            return .get
        case .teamRoster:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .draft(let year) :
            return "draft/nfl/trial/v1/en/\(year)/draft.json?api_key=eegavg9txm5q62k8r3zrkpxm"
        case .leagueLeaders(let year):
            return "trial/v8/en/seasons/\(year)/REG/leaders.json?api_key=eegavg9txm5q62k8r3zrkpxm"
        case .freeAgents:
            return "trial/v8/en/league/free_agents.json?api_key=eegavg9txm5q62k8r3zrkpxm"
        case .heirarchy:
            return "trial/v7/en/league/hierarchy.json?api_key=eegavg9txm5q62k8r3zrkpxm"
        case.teamRoster(let teamId):
            return "trial/v7/en/teams/\(teamId)/full_roster.json?api_key=eegavg9txm5q62k8r3zrkpxm"
        }
    }
    
    var baseUrl: String {
        switch self {
        case .draft:
            return "https://api.sportradar.us/"
        case .leagueLeaders,
                .freeAgents,
                .heirarchy,
                .teamRoster:
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
