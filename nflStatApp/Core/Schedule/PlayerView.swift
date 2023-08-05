//
//  PlayerView.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import SwiftUI

struct PlayerView: View {
    var freeAgent: Player
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
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}
