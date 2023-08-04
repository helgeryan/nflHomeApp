//
//  FreeAgentRowView.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/2/23.
//

import SwiftUI

struct FreeAgentRowView: View {
    let freeAgent: Player
    var body: some View {
            NavigationLink(destination: {
                PlayerView(freeAgent: freeAgent)
            }, label: {
                VStack(alignment: .leading) {
                    Text("\(freeAgent.getName()) - \(freeAgent.position)")
                        .foregroundColor(.black)
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                }
            })
            .listRowBackground(Color.white)
    }
}
