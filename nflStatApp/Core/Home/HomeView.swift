//
//  HomeView.swift
//  nflStatApp
//
//  Created by Ryan Helgeson on 8/4/23.
//

import SwiftUI

struct HomeView: View {
    @State var presentSideMenu: Bool = false
    @State var selectedSideMenuTab: Int = 0
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(Color.nfl)
            switch selectedSideMenuTab {
            case 0:
                VStack {
                    HeaderView(presentSideMenu: $presentSideMenu)
                    
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
            case 1:
                DraftView(presentSideMenu: $presentSideMenu)
            default:
                SeasonScheduleView(presentSideMenu: $presentSideMenu)
            }
            
            
            SideMenu(isShowing: $presentSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu)))
        }
    }
}
