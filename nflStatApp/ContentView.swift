//
//  ContentView.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import SwiftUI


struct ContentView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color.nfl)
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.gray)
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(Color.nfl)
        UITabBar.appearance().standardAppearance = appearance
    }
    var body: some View {
        TabView {
            HomeView()
                .tabItem{
                    Label("Home", systemImage: "house")
                }
            HeirarchyView()
                .tabItem{
                    Label("Teams", systemImage: "basketball.fill")
                }
            
            LeagueLeadersView()
                .tabItem{
                    Label("Leaders", systemImage: "trophy.fill")
                }
            
        }
        .tint(.white)
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

