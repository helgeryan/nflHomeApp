//
//  FreeAgentView.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import Foundation
import SwiftUI

struct FreeAgentListView: View {
    @Binding var presentSideMenu: Bool
    @StateObject var model: FreeAgentListViewModel = FreeAgentListViewModel()
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundColor(Color.white)
                if let freeAgents = model.freeAgents {
                    VStack {
                        HeaderView(presentSideMenu: $presentSideMenu)
                        Text(verbatim: "nfl Free Agent Tracker")
                            .font(.title)
                            .bold()
                            .foregroundColor(.black)
                        
                        Text(verbatim: "NFL's top free agents")
                            .font(.title2)
                            .foregroundColor(.gray)
                        
                        List {
                            Section("Free Agents") {
                                ForEach(freeAgents.free_agents, id: \.id) { freeAgent in
                                    FreeAgentRowView(freeAgent: freeAgent)
                                }
                            }
                        }
                        .tint(.clear)
                    }
                }
            }
        }
    }
}


