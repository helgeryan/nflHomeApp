//
//  FreeAgentView.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import Foundation
import SwiftUI

struct SeasonScheduleView: View {
    @Binding var presentSideMenu: Bool
    @StateObject var model: SeasonScheduleViewModel = SeasonScheduleViewModel()
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundColor(Color.white)
                if let schedule = model.schedule {
                    VStack {
                        HeaderView(presentSideMenu: $presentSideMenu)
                        Text(verbatim: "NFL Season Schedule")
                            .font(.title)
                            .bold()
                            .foregroundColor(.black)
                        
                        List {
                            ForEach(schedule.weeks, id: \.id, content: { week in
                                Section(content: {
                                    ForEach(week.games, id: \.id) { game in
                                        GameRowView(game: game)
                                    }
                                }, header: {
                                    HStack {
                                        Text("Week \(week.title)")
                                            .foregroundColor(.black)
                                            .font(.system(size: 17))
                                            .fontWeight(.semibold)
                                    }
                                })
                            })
                        }
                        .tint(.clear)
                    }
                }
            }
        }
    }
}


struct GameRowView: View {
    let game: Game
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                TeamBasicView(team: game.away)
                    .frame(width: 100)
                Spacer()
                VStack {
                    Text("@")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .font(.system(size: 16))
                    if let scheduled = game.getScheduledDate() {
                        Text(scheduled)
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                            .font(.system(size: 12))
                            .multilineTextAlignment(.center)
                    }
                    if let broadcast = game.broadcast {
                            Image(broadcast.network.replacingOccurrences(of: "/", with: ""))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                    }
                }
                Spacer()
                TeamBasicView(team: game.home)
                    .frame(width: 100)
            }.padding(.horizontal, 10)
            
            Text(game.venue.name)
                .multilineTextAlignment(.center)
                .font(.system(size: 13))
                .fontWeight(.semibold)
        }
        .padding(.vertical)
    }
}

struct TeamBasicView: View {
    let team: TrimmedTeam
    var body: some View {
        VStack(spacing: 5) {
            let teamName = Team.teamNames.first(where: { team.name.contains($0) })
            Image(teamName!)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .clipped()
            Text(team.name)
                .multilineTextAlignment(.center)
                .font(.system(size: 12))
                .fontWeight(.semibold)
        }
    }
}
