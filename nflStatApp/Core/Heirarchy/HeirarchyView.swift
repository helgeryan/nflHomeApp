//
//  HeirarchyView.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import SwiftUI

struct HeirarchyTabView: View {
    var body: some View {
        MainTabView(sideMenuHomeTabName: "League", coreViewBackground: .white, content: AnyView(HeirarchyView()))
    }
}

struct HeirarchyView: View {
    @StateObject var model: HeirarchyViewModel = HeirarchyViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    if let heirarchy = model.heirarchy {
                        HStack {
                            Spacer()
                            Text(verbatim: "NFL Heirarchy")
                                .font(.title)
                                .bold()
                                .foregroundColor(.black)
                            Spacer()
                        }
                        Spacer()
                        ForEach(heirarchy.conferences, id: \.id) { conference in
                            Text(conference.name)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .padding()
                            
                            ForEach(conference.divisions ?? [], id: \.id) { division in
                                Text(division.name)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                    .padding(.horizontal)
                                ForEach(division.teams ?? [], id: \.id) { team in
                                    TeamRowView(team: team)
                                }
                            }
                        }
                    }
                }
            }.background(Color.white)
        }
    }
}

struct HeirarchyView_Previews: PreviewProvider {
    static var previews: some View {
        HeirarchyView()
    }
}


struct TeamRowView: View {
    let team: Team
    var body: some View {
        let foregroundColor = Color(hex: team.team_colors?[0].hex_color ?? "000000")
        let backgroundColor = Color(hex: team.team_colors?[1].hex_color ?? "FFFFFF")
        NavigationLink {
            TeamView(model: TeamViewModel(team: team))
        } label: {
            ZStack {
                Rectangle()
                    .clipped()
                    .cornerRadius(10)
                    .foregroundColor(backgroundColor)
                
                VStack {
                    Text("\(team.market) \(team.name)")
                        .foregroundColor(foregroundColor)
                        .font(.system(size: 16))
                        .bold()
                        .padding()
                }
            }
            .padding(.horizontal)
        }
        
    }
}
