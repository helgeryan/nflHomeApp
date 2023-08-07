//
//  PlayerView.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import SwiftUI

@MainActor
class PlayerViewModel: ObservableObject {
    @Published var player: Player
    
    init(player: Player) {
        self.player = player
        fetchPlayer()
    }
    
    func fetchPlayer() {
        Task {
            if let player = await NFLService().getPlayerProfile(playerId: player.id) {
                self.player = player
            }
        }
    }
}

struct PlayerView: View {
    @StateObject var model: PlayerViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.dismiss()
                }, label: {
                    Label("Back", systemImage: "chevron.left")
                        .foregroundColor(.black)
                })
                Spacer()
            }.padding()
            Image("nflLogo")
                .frame(width: 176, height: 176)
                .cornerRadius(88)
                .clipped()
                .scaledToFit()
            Text(verbatim: model.player.getName())
                .font(.title)
                .bold()
                .foregroundColor(.black)
            if let inches = model.player.heightInches,
               let feet = model.player.heightFeet {
                Text(verbatim: "\(feet)'\(inches) \u{2022} \(model.player.position)")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
            if let college = model.player.college {
                Text(college)
                    .font(.title2)
                    .foregroundColor(.black)
            }
            
            if let seasons = model.player.seasons {
                StatsView(seasons: seasons)
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct StatsView: View {
    var seasons: [Season]
    
    var atts: [String] = [
        "Year",
        "Att",
        "Cmp",
        "Cmp%",
        "Yds",
        "TDs",
        "Long",
        "Int",
        "Long TD",
        "Rat"
    ]
    
    var body: some View {
        ScrollView {
            ScrollView(.horizontal) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        ForEach(atts, id: \.self, content: { att in
                            Text(att)
                                .frame(width: 80)
                                .foregroundColor(.white)
                        })
                    }
                    .background(Color.nfl)
                    .padding(.bottom , 2)
                    
                    ForEach(seasons, id: \.id) { season in
                        if let teams = season.teams, season.type == "REG" {
                            PassingStatsView(teams: teams, year: season.year)
                                .padding(.bottom ,2)
                        }
                    }
                }
                .background(Color(hex: "EEEEEE"))
                .cornerRadius(12)
                .padding()
            }
        }
    }
}

struct PassingStatsView: View {
    var teams: [TeamSeasonStats]
    var year: Int
    var body: some View {
        ForEach(teams, id: \.id) { team in
            if let passingStats = team.statistics.passing {
                HStack {
                    StatView(stat: year)
                    StatView(stat: passingStats.attempts)
                    StatView(stat: passingStats.completions)
                    StatView(stat: passingStats.cmp_pct)
                    StatView(stat: passingStats.yards)
                    StatView(stat: passingStats.touchdowns)
                    StatView(stat: passingStats.longest)
                    StatView(stat: passingStats.interceptions)
                    StatView(stat: passingStats.longest_touchdown)
                    StatView(stat: passingStats.rating)
                }
            }
        }
    }
}

struct StatView: View {
    var stat: Any
    var body: some View {
        if let stat = stat as? Double {
            Text(String(format: "%0.1f", stat))
                .frame(width: 80)
        }
        
        if let stat = stat as? Int {
            Text(String(format: "%d", stat))
                .frame(width: 80)
        }
    }
}
