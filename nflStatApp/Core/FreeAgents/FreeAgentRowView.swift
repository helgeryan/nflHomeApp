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
                FreeAgentView(freeAgent: freeAgent)
            }, label: {
                VStack(alignment: .leading) {
                    Text("\(freeAgent.getName()) - \(freeAgent.position)")
                        .foregroundColor(.black)
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                    Text("\(freeAgent.experience ?? 0) years experience")
                        .foregroundColor(.black)
                        .font(.system(size: 13))
                        .fontWeight(.semibold)
                }
            })
            .listRowBackground(Color.white)
    }
}
