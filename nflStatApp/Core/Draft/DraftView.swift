//
//  DraftView.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import SwiftUI

struct DraftView: View {
    @StateObject var model: DraftViewModel = DraftViewModel()
    var body: some View {
        NavigationStack {
            ZStack {
                if let draft = model.draft {
                    VStack {
                        Text(verbatim: "NFL Draft \(draft.draft.year)")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                        if let state = draft.draft.venue.state {
                            Text(verbatim: "\(draft.draft.venue.name) \(draft.draft.venue.city), \(state)")
                                .font(.title2)
                                .foregroundColor(.gray)
                        } else {
                            Text(verbatim: "\(draft.draft.venue.name) \(draft.draft.venue.city)")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                        
                        List {
                            ForEach(draft.rounds, id: \.id, content: { round in
                                Section("Round \(round.number)") {
                                    ForEach(round.picks, id: \.id) { pick in
                                        ProspectRowView(round: round, pick: pick)
                                    }
                                }
                            })
                        }
                        .tint(.clear)
                    }
                }
            }
        }
    }
}

struct DraftView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
