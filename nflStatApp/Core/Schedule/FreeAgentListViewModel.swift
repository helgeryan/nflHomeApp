//
//  FreeAgentListViewModel.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import SwiftUI

@MainActor
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
        Task {
            if let sched = await NFLService().getSeasonSchedule(year: year) {
                self.schedule = sched
            }
        }
    }
}


