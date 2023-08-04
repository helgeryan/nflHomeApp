//
//  NFLService.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import Foundation
import SwiftUI
import Alamofire

class NFLService {
    static let draftUrl: String = "http://api.sportradar.us/draft/nfl/trial/v1/en/2022/draft.json?api_key=k2xr9d2twcy2cbv5ncn6adhf"
    
    let manager = NFLNetworkManager()
    func getDraft(completion: @escaping (DraftResponse?) -> ()) {
        let router = NFLApiAction.draft(year: 2021)
        manager.makeRequest(router: router, useMockData: true, completion: completion)
    }
    
    func getFreeAgents(completion: @escaping (FreeAgentResponse?) -> ()) {
        let router = NFLApiAction.freeAgents
        manager.makeRequest(router: router, useMockData: true, completion: completion)
    }
    
    func getHeirarchy(completion: @escaping (HeirarchyResponse?) -> ()) {
        let router = NFLApiAction.heirarchy
        manager.makeRequest(router: router, useMockData: true, completion: completion)
    }
    
    func getLeagueLeaders(completion: @escaping (LeagueLeadersResponse?) -> ()) {
        let router = NFLApiAction.leagueLeaders(year: 2021)
        manager.makeRequest(router: router, useMockData: true, completion: completion)
    }
    
    func getTeam(teamId: String, completion: @escaping (Team?) -> ()) {
        let router = NFLApiAction.teamRoster(teamId: teamId)
        manager.makeRequest(router: router, useMockData: true, completion: completion)
    }
}


