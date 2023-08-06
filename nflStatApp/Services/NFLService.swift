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
    func getDraft(year: Int) async -> DraftResponse? {
        let router = NFLApiAction.draft(year: year)
        return await manager.makeRequest(router: router, useMockData: true)
    }
    
    func getSeasonSchedule(year: Int) async -> ScheduleResponse? {
        let router = NFLApiAction.schedule(year: year)
        return await manager.makeRequest(router: router, useMockData: true)
    }
    
    func getHeirarchy() async -> HeirarchyResponse? {
        let router = NFLApiAction.heirarchy
        return await manager.makeRequest(router: router, useMockData: true)
    }
    
    func getLeagueLeaders(year: Int) async -> LeagueLeadersResponse? {
        let router = NFLApiAction.leagueLeaders(year: year)
        return await manager.makeRequest(router: router, useMockData: true)
    }
    
    func getTeam(teamId: String) async -> Team? {
        let router = NFLApiAction.teamRoster(teamId: teamId)
        return await manager.makeRequest(router: router, useMockData: true)
    }
    
    func getDailyTransactions(date: Date) async -> DailyTransactionResponse? {
        let router = NFLApiAction.dailyTransactions(date: date)
        return await manager.makeRequest(router: router, useMockData: true)
    }
    
    func getPlayerProfile(playerId: String) async -> Player? {
        let router = NFLApiAction.playerProfile(playerId: playerId)
        return await manager.makeRequest(router: router, useMockData: true)
    }
}
