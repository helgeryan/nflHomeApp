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
    @StateObject var model: HomeViewModel = HomeViewModel()
    var body: some View {
        ScrollView {
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
            Text("Today's News")
                .foregroundColor(.white)
                .font(.title3)
                .fontWeight(.bold)
            VStack(spacing: 1) {
                ForEach(model.transactions, id: \.id) { transaction in
                    TranscationView(transaction: transaction)
                }
            }
            .clipped()
            .cornerRadius(10)
            .padding(.horizontal)
        }
        Spacer()
    }
}

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

@MainActor
class HomeViewModel: ObservableObject {
    @Published var transactions: [Transcation] = []
    
    init() {
        Task {
            if let transactionResponse = await NFLService().getDailyTransactions(date: Date()) {
                var transactionArray:[Transcation] = []
                for player in transactionResponse.players {
                    if let trans = player.transactions {
                        transactionArray.append(contentsOf: trans)
                    }
                }
                self.transactions = transactionArray
            }
        }
    }
}
