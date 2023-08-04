//
//  FreeAgentListViewModel.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import SwiftUI

class FreeAgentListViewModel: ObservableObject {
    @Published var freeAgents: FreeAgentResponse?
    init() {
        NFLService().getFreeAgents(completion: { freeAgents in
            self.freeAgents = freeAgents
        })
    }
}
