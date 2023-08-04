//
//  GameRowView.swift
//  nflStatApp
//
//  Created by Ryan Helgeson on 8/4/23.
//

import SwiftUI

struct GameRowView: View {
    let game: Game
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                TeamBasicView(team: game.away, score: game.scoring?.away_points)
                    .frame(width: 100)
                Spacer()
                VStack(spacing: 6) {
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
                                .frame(width: 40, height: 30)
                    }
                }
                Spacer()
                TeamBasicView(team: game.home, score: game.scoring?.home_points)
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
