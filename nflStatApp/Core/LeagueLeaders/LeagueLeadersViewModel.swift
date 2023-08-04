//
//  LeagueLeadersViewModel.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import Foundation
import SwiftUI

class LeagueLeadersViewModel: ObservableObject {
    @Published var leagueLeaders: LeagueLeadersResponse?
    var year: Int = 2023
    init() {
        NFLService().getLeagueLeaders(year: year, completion: { leagueLeaders in
            self.leagueLeaders = leagueLeaders
        })
    }
}
