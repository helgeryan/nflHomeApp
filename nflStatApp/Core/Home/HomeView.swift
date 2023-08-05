//
//  HomeView.swift
//  nflStatApp
//
//  Created by Ryan Helgeson on 8/4/23.
//

import SwiftUI

struct HomeTabView: View {
    var body: some View {
        MainTabView(sideMenuHomeTabName: "Home", content: AnyView(HomeView()))
    }
}


struct MainTabView: View {
    let sideMenuHomeTabName: String
    @State var presentSideMenu: Bool = false
    @State var selectedSideMenuTab: Int = 0
    var coreViewBackground: Color = .nfl
    var content : AnyView
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(Color.nfl)
            switch selectedSideMenuTab {
            case 0:
                CoreView(presentSideMenu: $presentSideMenu, backgroundColor: coreViewBackground, content: content)
                    
            case 1:
                CoreView(presentSideMenu: $presentSideMenu, backgroundColor: .nfl, content:
                            AnyView(DraftView()))
            default:
                CoreView(presentSideMenu: $presentSideMenu, backgroundColor: Color.white, content: AnyView(SeasonScheduleView()))
                
            }
            
            
            SideMenu(isShowing: $presentSideMenu, content: AnyView(SideMenuView(sideMenuHomeTabName: sideMenuHomeTabName, selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu)))
        }
    }
}

struct HomeView: View {
    var body: some View {
        VStack {
            Text(verbatim: "NFL Home")
                .font(.title)
                .bold()
                .foregroundColor(.white)
            Image("nflLogo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
                .frame(width: 176, height: 176)
                .cornerRadius(88)
            Text("Welcome to the NFL Home App")
                .font(.title2)
                .bold()
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.top)
            Text("Your home to all information NFL")
                .font(.title3)
                .bold()
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
}
