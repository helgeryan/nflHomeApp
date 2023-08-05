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
                .frame(width: 140, height: 140)
                .cornerRadius(70)
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
                .padding(.top, 10)
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
