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
    func getDraft(year: Int, completion: @escaping (DraftResponse?) -> ()) {
        let router = NFLApiAction.draft(year: year)
        manager.makeRequest(router: router, useMockData: true, completion: completion)
    }
    
    func getSeasonSchedule(year: Int, completion: @escaping (ScheduleResponse?) -> ()) {
        let router = NFLApiAction.schedule(year: year)
        manager.makeRequest(router: router, useMockData: true, completion: completion)
    }
    
    func getHeirarchy(completion: @escaping (HeirarchyResponse?) -> ()) {
        let router = NFLApiAction.heirarchy
        manager.makeRequest(router: router, useMockData: true, completion: completion)
    }
    
    func getLeagueLeaders(year: Int, completion: @escaping (LeagueLeadersResponse?) -> ()) {
        let router = NFLApiAction.leagueLeaders(year: year)
        manager.makeRequest(router: router, useMockData: true, completion: completion)
    }
    
    func getTeam(teamId: String, completion: @escaping (Team?) -> ()) {
        let router = NFLApiAction.teamRoster(teamId: teamId)
        manager.makeRequest(router: router, useMockData: true, completion: completion)
    }
}


