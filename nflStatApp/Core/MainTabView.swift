//
//  MainTabView.swift
//  nflStatApp
//
//  Created by Ryan Helgeson on 8/5/23.
//

import SwiftUI


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
