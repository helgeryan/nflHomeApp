//
//  TransactionView.swift
//  nflStatApp
//
//  Created by Ryan Helgeson on 8/5/23.
//

import SwiftUI

struct TranscationView: View {
    let transaction: Transcation
    var body: some View {
        HStack {
            if let team = transaction.from_team {
                Image(team.name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .padding(6)
                if let to_team = transaction.to_team, to_team.id != team.id {
                    Image(to_team.name)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                }
            } else if let team = transaction.to_team {
                Image(team.name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .padding(6)
            }
            Text(transaction.desc)
                .font(.system(size: 12))
                .fontWeight(.semibold)
            Spacer()
        }
        .background(Color.white)
    }
}
