//
//  LeagueLeaderRowView.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/2/23.
//

import SwiftUI

struct LeagueLeaderRowView: View {
    let category: StatCategory
    var body: some View {
        let leader = category.ranks.first!
        NavigationLink(destination: {
            PlayerView(freeAgent: leader.player)
        }, label: {
            VStack(alignment: .center, spacing: 0) {
                HStack {
                    Text(category.cleanName)
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                    Spacer()
                    Text(category.type.capitalized)
                        .foregroundColor(Color(hex: "DDDDDD"))
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                }
                .padding()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(leader.player.getName())
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                        
                        if leader.score > 1 {
                            Text(String(format: "%0.0f", leader.score))
                                .foregroundColor(Color(hex: "DDDDDD"))
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                                .padding(.bottom)
                        } else {
                            Text(String(format: "%0.2f%%", leader.score))
                                .foregroundColor(Color(hex: "DDDDDD"))
                                .font(.system(size: 24))
                                .fontWeight(.bold)
                                .padding(.bottom)
                        }
                    }.padding(.leading)
                    
                    Spacer()
                    
                    ForEach(leader.teams, id: \.id) { team in
                        Image(team.name)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(25)
                            .clipped()
                            .aspectRatio( contentMode: .fill)
                            .padding([.bottom, .trailing])
                    }
                }
                
            }
            .background(Color.nbaRed.clipShape(RoundedRectangle(cornerRadius:10)))
            .padding([.horizontal])
        })
    }
}
