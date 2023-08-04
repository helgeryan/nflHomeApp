//
//  LeagueLeadersView.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import SwiftUI

struct LeagueLeadersView: View {
    @StateObject var model: LeagueLeadersViewModel = LeagueLeadersViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .center) {
                    Text("League Leaders")
                        .foregroundColor(.black)
                        .font(.title)
                        .fontWeight(.bold)
                    if let leagueLeaders = model.leagueLeaders {
                        ForEach(leagueLeaders.categories, id: \.id, content: { category in
                            LeagueLeaderRowView(category: category)
                        })
                    }
                }
            }
        }
    }
}

struct LeagueLeadersView_Previews: PreviewProvider {
    static var previews: some View {
        LeagueLeadersView()
    }
}

