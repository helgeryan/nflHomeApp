//
//  TeamView.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import Foundation
import SwiftUI

@MainActor
class TeamViewModel: ObservableObject {
    @Published var team: Team
    @Published var foregroundColor: Color = .black
    @Published var backgroundColor: Color = .white
    init(team: Team) {
        self.team = team
        setColors()
    }
    
    func fetchTeam() {
        Task {
            if let teamResponse = await NFLService().getTeam(teamId: team.id) {
                self.team = teamResponse
                self.setColors()
            }
        }
    }
    
    func setColors() {
        if let foregroundColor = self.team.team_colors?[0].hex_color {
            self.foregroundColor = Color(hex: foregroundColor)
        }
        if let backgroundColor = self.team.team_colors?[1].hex_color {
            self.backgroundColor = Color(hex: backgroundColor)
        }
    }
}

struct TeamView: View {
    @StateObject var model: TeamViewModel
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 0) {
                Image(model.team.name)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 176, height: 176)
                    .clipped()
                    .cornerRadius(88)
                Text("\(model.team.market) \(model.team.name)")
                    .foregroundColor(model.foregroundColor)
                    .font(.title)
                    .bold()
                    .padding(4)
                if let venue = model.team.venue {
                    Text(venue.name + " " + venue.city)
                        .foregroundColor(model.foregroundColor)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                }
                
                if let conference = model.team.conference {
                    Text(conference.name)
                        .foregroundColor(model.foregroundColor)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                }
                
                if let division = model.team.division {
                    Text(division.name)
                        .foregroundColor(model.foregroundColor)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                }
                
                RosterView(team: model.team, foregroundColor: model.foregroundColor)
                
                Spacer()
            }
            Spacer()
        }
        .onAppear {
            model.fetchTeam()
        }
        .background(model.backgroundColor)
    }
}

struct RosterView: View {
    var team: Team
    var foregroundColor: Color
    var body: some View {
        List {
            let qbs = Player.filterForPositionGroup(players: team.players ?? [], filterParams: ["QB"])
            PositionGroupView(players: qbs, title: "Quarterbacks", foregroundColor: foregroundColor)
            
            let wrs = Player.filterForPositionGroup(players: team.players ?? [], filterParams: ["WR"])
            PositionGroupView(players: wrs, title: "Wide Receivers", foregroundColor: foregroundColor)
            
            let rbs = Player.filterForPositionGroup(players: team.players ?? [], filterParams: ["RB", "FB"])
            PositionGroupView(players: rbs, title: "Running Backs", foregroundColor: foregroundColor)
            
            let dl = Player.filterForPositionGroup(players: team.players ?? [], filterParams: ["DL", "DE", "DT", "NT"])
            PositionGroupView(players: dl, title: "Defensive Line", foregroundColor: foregroundColor)
            
            let lb = Player.filterForPositionGroup(players: team.players ?? [], filterParams: ["OLB", "LB", "ILB"])
            PositionGroupView(players: lb, title: "Line Backers", foregroundColor: foregroundColor)
            
            let dbs = Player.filterForPositionGroup(players: team.players ?? [], filterParams: ["CB", "SAF"])
            PositionGroupView(players: dbs, title: "Defensive Backs", foregroundColor: foregroundColor)
            
            
            let special = Player.filterForPositionGroup(players: team.players ?? [], filterParams: ["K", "P", "LS"])
            PositionGroupView(players: special, title: "Special Teams", foregroundColor: foregroundColor)
            
            Section(content: {
                ForEach(team.coaches ?? [], id: \.id) { coach in
                    Text(coach.full_name)
                }
            }, header: {
                HStack {
                    Text("Coaches")
                        .foregroundColor(foregroundColor)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            })
        }
        .scrollContentBackground(.hidden)

    }
}

struct PositionGroupView: View {
    let players: [Player]
    let title: String
    let foregroundColor: Color
    var body: some View {
        Section(content: {
            ForEach(players, id: \.id) { player in
                NavigationLink(destination: {
                    PlayerView(model: PlayerViewModel(player: player))
                }, label: {
                    HStack {
                        Text("#" + (player.jersey ?? "00"))
                        Text(player.getName() + " \u{2022} " + player.position)
                        Spacer()
                    }
                })
            }
        }, header: {
            HStack {
                Text(title)
                    .foregroundColor(foregroundColor)
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                Spacer()
            }
        })
        
    }
}
