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
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}
