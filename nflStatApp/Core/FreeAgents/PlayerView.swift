//
//  PlayerView.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import SwiftUI

struct FreeAgentView: View {
    var freeAgent: Player
    var body: some View {
        VStack {
            Image("nbaLogo")
                .frame(width: 176, height: 176)
                .cornerRadius(88)
                .clipped()
                .scaledToFit()
            Text(verbatim: freeAgent.getName())
                .font(.title)
                .bold()
                .foregroundColor(.black)
            if let inches = freeAgent.heightInches,
               let feet = freeAgent.heightFeet {
                Text(verbatim: "\(feet)'\(inches) \u{2022} \(freeAgent.position)")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
            if let college = freeAgent.college {
                Text(college)
                    .font(.title2)
                    .foregroundColor(.black)
            }
        }
    }
}
