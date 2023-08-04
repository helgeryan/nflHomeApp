//
//  TeamView.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import Foundation
import SwiftUI

class TeamViewModel: ObservableObject {
    @Published var team: Team
    @Published var foregroundColor: Color = .black
    @Published var backgroundColor: Color = .white
    init(team: Team) {
        self.team = team
        setColors()
    }
    
    func fetchTeam() {
        NFLService().getTeam(teamId: team.id, completion: { teamResponse in
            if let teamResponse = teamResponse {
                self.team = teamResponse
                self.setColors()
            }
        })
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
                
                RosterView(model: model)
                
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
    let model: TeamViewModel
    var body: some View {
        List {
            let qbs = Player.filterForPositionGroup(players: model.team.players ?? [], filterParams: ["QB"])
            PositionGroupView(players: qbs, title: "Quarterbacks", foregroundColor: model.foregroundColor)
            
            let wrs = Player.filterForPositionGroup(players: model.team.players ?? [], filterParams: ["WR"])
            PositionGroupView(players: wrs, title: "Wide Receivers", foregroundColor: model.foregroundColor)
            
            let rbs = Player.filterForPositionGroup(players: model.team.players ?? [], filterParams: ["RB", "FB"])
            PositionGroupView(players: rbs, title: "Running Backs", foregroundColor: model.foregroundColor)
            
            let dl = Player.filterForPositionGroup(players: model.team.players ?? [], filterParams: ["DL", "DE", "DT", "NT"])
            PositionGroupView(players: dl, title: "Defensive Line", foregroundColor: model.foregroundColor)
            
            let lb = Player.filterForPositionGroup(players: model.team.players ?? [], filterParams: ["OLB", "LB", "ILB"])
            PositionGroupView(players: lb, title: "Line Backers", foregroundColor: model.foregroundColor)
            
            let dbs = Player.filterForPositionGroup(players: model.team.players ?? [], filterParams: ["CB", "SAF"])
            PositionGroupView(players: dbs, title: "Defensive Backs", foregroundColor: model.foregroundColor)
            
            
            let special = Player.filterForPositionGroup(players: model.team.players ?? [], filterParams: ["K", "P", "LS"])
            PositionGroupView(players: special, title: "Special Teams", foregroundColor: model.foregroundColor)
            
            Section(content: {
                ForEach(model.team.coaches ?? [], id: \.id) { coach in
                    Text(coach.full_name)
                }
            }, header: {
                HStack {
                    Text("Coaches")
                        .foregroundColor(model.foregroundColor)
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
                    PlayerView(freeAgent: player)
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
