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
    let manager = NFLNetworkManager()
    func getDraft(completion: @escaping (DraftResponse?) -> ()) {
        let router = NFLApiAction.draft(year: 2022)
        manager.makeRequest(router: router, useMockData: true, completion: completion)
    }
    
    func getFreeAgents(completion: @escaping (FreeAgentResponse?) -> ()) {
        let router = NFLApiAction.freeAgents
        manager.makeRequest(router: router, useMockData: false, completion: completion)
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


