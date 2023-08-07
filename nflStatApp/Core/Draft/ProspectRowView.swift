//
//  ProspectRowView.swift
//  nflApp
//
//  Created by Ryan Helgeson on 8/2/23.
//

import SwiftUI

struct ProspectRowView: View {
    let round: Round
    let pick: Pick
    var body: some View {
        NavigationLink(destination: {
            PlayerView(model: PlayerViewModel(player: pick.prospect))
        }, label: {
            VStack(alignment: .leading) {
                HStack {
                    Text("R\(round.number):P\(pick.number) - \(pick.team.market) \(pick.team.name)")
                        .foregroundColor(.black)
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                    Image(pick.team.name)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                }
                Text(pick.prospect.name ?? pick.prospect.full_name ?? "\(pick.prospect.first_name) \(pick.prospect.last_name)")
                    .foregroundColor(.black)
                    .font(.system(size: 16))
                    .fontWeight(.bold)
            }
        })
    }
}
