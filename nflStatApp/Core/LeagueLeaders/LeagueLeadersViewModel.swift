//
//  LeagueLeadersViewModel.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import Foundation
import SwiftUI

@MainActor
class LeagueLeadersViewModel: ObservableObject {
    @Published var leagueLeaders: LeagueLeadersResponse?
    var year: Int = 2023
    init() {
        Task {
            if let leaders = await NFLService().getLeagueLeaders(year: year) {
                self.leagueLeaders = leaders
            }
        }
    }
}
