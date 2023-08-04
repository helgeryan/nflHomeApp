//
//  TeamBasicView.swift
//  nflStatApp
//
//  Created by Ryan Helgeson on 8/4/23.
//

import SwiftUI

struct TeamBasicView: View {
    let team: TrimmedTeam
    let score: Int?
    var body: some View {
        VStack(spacing: 5) {
            if let score = score {
            Text("\(score)")
                .font(.system(size: 26))
                .fontWeight(.bold)
            }
            if let teamName = Team.teamNames.first(where: { team.name.contains($0) }) {
                Image(teamName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .clipped()
            }
                
            Text(team.name)
                .multilineTextAlignment(.center)
                .font(.system(size: 12))
                .fontWeight(.semibold)
            Spacer()
        }
    }
}
