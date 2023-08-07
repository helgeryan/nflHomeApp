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
    
    var body: some View {
        ScrollView {
            ScrollView(.horizontal) {
                VStack(alignment: .leading) {
                    
                    Text("Passing")
                        .foregroundColor(.black)
                        .bold()
                        .font(.title3)
                        .padding(.horizontal)
                    VStack(alignment: .leading, spacing: 0) {
                        StatHeaderView(statType: .pass)
                        
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
                    
                    
                    Text("Rushing")
                        .foregroundColor(.black)
                        .bold()
                        .font(.title3)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        StatHeaderView(statType: .rush)
                        ForEach(seasons, id: \.id) { season in
                            if let teams = season.teams, season.type == "REG" {
                                RushingStatsView(teams: teams, year: season.year)
                                    .padding(.bottom ,2)
                            }
                        }
                    }
                    .background(Color(hex: "EEEEEE"))
                    .cornerRadius(12)
                    .padding()
                    
                    Text("Receiving")
                        .foregroundColor(.black)
                        .bold()
                        .font(.title3)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        StatHeaderView(statType: .receive)
                        ForEach(seasons, id: \.id) { season in
                            if let teams = season.teams, season.type == "REG" {
                                ReceivingStatsView(teams: teams, year: season.year)
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

enum StatType {
    case rush
    case pass
    case receive
    
    var attributes: [String] {
        switch self {
        case .pass:
            return [ "Year",  "Att", "Cmp", "Cmp%", "Yds", "TDs", "Long", "Int", "Long TD", "Rat"]
        case .receive:
            return [ "Year",  "Tar", "Rec", "Yds", "TDs", "Long", "Long TD", "RZ Tar"]
        case .rush:
            return [ "Year", "Att", "Yds", "TDs", "Long", "Long TD", "RZ Att"]
        }
    }
}


struct StatHeaderView: View {
    
    var statType: StatType
    
    var body: some View {
        HStack {
            ForEach(statType.attributes, id: \.self, content: { att in
                Text(att)
                    .frame(width: 80)
                    .foregroundColor(.white)
                    .bold()
                    .padding(.bottom, 2)
            })
        }
        .background(Color.nfl)
        .padding(.bottom , 2)
        
    }
}

struct RushingStatsView: View {
    var teams: [TeamSeasonStats]
    var year: Int
    var body: some View {
        
        ForEach(teams, id: \.id) { team in
            if let rushingStarts = team.statistics.rushing {
                HStack {
                    StatView(stat: year)
                    StatView(stat: rushingStarts.attempts)
                    StatView(stat: rushingStarts.yards)
                    StatView(stat: rushingStarts.touchdowns)
                    StatView(stat: rushingStarts.longest)
                    StatView(stat: rushingStarts.longest_touchdown)
                    StatView(stat: rushingStarts.redzone_attempts)
                }
            }
        }
    }
}

struct ReceivingStatsView: View {
    var teams: [TeamSeasonStats]
    var year: Int
    var body: some View {
        ForEach(teams, id: \.id) { team in
            if let receivingStats = team.statistics.receiving {
                HStack {
                    StatView(stat: year)
                    StatView(stat: receivingStats.targets)
                    StatView(stat: receivingStats.receptions)
                    StatView(stat: receivingStats.yards)
                    StatView(stat: receivingStats.touchdowns)
                    StatView(stat: receivingStats.longest)
                    StatView(stat: receivingStats.longest_touchdown)
                    StatView(stat: receivingStats.redzone_targets)
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
