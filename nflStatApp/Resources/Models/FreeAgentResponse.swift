//
//  FreeAgentResponse.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import Foundation

struct FreeAgentResponse: Codable {
    let league: League
    let free_agents: [Player]
}
