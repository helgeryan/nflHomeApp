//
//  FreeAgentRowView.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/2/23.
//

import SwiftUI

struct FreeAgentRowView: View {
    let player: Player
    var body: some View {
            NavigationLink(destination: {
                PlayerView(model: PlayerViewModel(player: player))
            }, label: {
                VStack(alignment: .leading) {
                    Text("\(player.getName()) - \(player.position)")
                        .foregroundColor(.black)
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                }
            })
            .listRowBackground(Color.white)
    }
}
