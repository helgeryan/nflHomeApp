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
    init() {
        NFLService().getLeagueLeaders(completion: { leagueLeaders in
            self.leagueLeaders = leagueLeaders
        })
    }
}
