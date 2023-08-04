//
//  FreeAgentView.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import Foundation
import SwiftUI

struct SeasonScheduleView: View {
    @Binding var presentSideMenu: Bool
    @StateObject var model: SeasonScheduleViewModel = SeasonScheduleViewModel()
    
    @State private var selection = 2023
    let years = Array((2015...2023).reversed())

    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundColor(Color.white)
                if let schedule = model.schedule {
                    VStack {
                        HeaderView(presentSideMenu: $presentSideMenu)
                        Text(verbatim: "NFL Season Schedule")
                            .font(.title)
                            .bold()
                            .foregroundColor(.black)
                        
                        Picker("Select a season", selection: $selection) {
                            ForEach(years, id: \.self) { year in
                                Text(verbatim: "\(year) Season")
                                    .foregroundColor(.black)
                            }
                        }
                        .pickerStyle(.menu)
                        .tint(.blue)
                        .onChange(of: selection, perform: { _ in
                            model.year = selection
                        })
                        ScrollView {
                            
                            LazyVStack(pinnedViews: [.sectionHeaders]) {
                                ForEach(schedule.weeks, id: \.id, content: { week in
                                    Section(content: {
                                        ForEach(week.games, id: \.id) { game in
                                            GameRowView(game: game)
                                        }
                                    }, header: {
                                        HStack {
                                            Text("Week \(week.title)")
                                                .foregroundColor(.white)
                                                .font(.system(size: 17))
                                                .fontWeight(.semibold)
                                            Spacer()
                                        }
                                        .padding()
                                        .background(Color.nfl)
                                    })
                                })
                            }
                        }
                    }
                }
            }
        }
    }
}
