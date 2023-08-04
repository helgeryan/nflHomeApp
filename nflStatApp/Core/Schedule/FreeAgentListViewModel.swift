//
//  FreeAgentListViewModel.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import SwiftUI

class SeasonScheduleViewModel: ObservableObject {
    @Published var schedule: ScheduleResponse?
    var year: Int = 2023 {
        didSet {
            fetchSeasonSchedule()
        }
    }
    init() {
        fetchSeasonSchedule()
    }
    
    func fetchSeasonSchedule() {
        NFLService().getSeasonSchedule(year: year, completion: { schedule in
            self.schedule = schedule
        })
    }
}


