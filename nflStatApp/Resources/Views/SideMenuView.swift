//
//  SideMenuView.swift
//  tcrp
//
//  Created by Ryan Helgeson on 7/24/23.
//

import SwiftUI

struct SideMenuView: View {
    let sideMenuHomeTabName: String
    @Binding var selectedSideMenuTab: Int
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        HStack {
            
            ZStack{
                Rectangle()
                    .fill(.white)
                    .frame(width: 270)
                    .shadow(color: Color.nfl.opacity(0.1), radius: 5, x: 0, y: 3)
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    ForEach(SideMenuRowType.allCases, id: \.self){ row in
                        if row == .home {
                            RowView(isSelected: selectedSideMenuTab == row.rawValue, imageName: row.iconName, title: sideMenuHomeTabName) {
                                selectedSideMenuTab = row.rawValue
                                presentSideMenu.toggle()
                            }
                        } else {
                            RowView(isSelected: selectedSideMenuTab == row.rawValue, imageName: row.iconName, title: row.title) {
                                selectedSideMenuTab = row.rawValue
                                presentSideMenu.toggle()
                            }
                        }
                    }

                    Spacer()
                }
                .padding(.top, 100)
                .frame(width: 270)
                .background(
                    Color.white
                )
            }
            
            
            Spacer()
        }
        .background(.clear)
    }
    
    func ProfileImageView() -> some View {
        VStack(alignment: .center) {
            HStack{
                Spacer()
                Image(systemName: "person")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.nfl.opacity(1), lineWidth: 3)
                            
                    )
                    .cornerRadius(50)
                Spacer()
            }
        }
    }
    
    func RowView(isSelected: Bool, imageName: String, title: String, hideDivider: Bool = false, action: @escaping (()->())) -> some View {
        Button{
            action()
        } label: {
            VStack(alignment: .leading) {
                HStack(spacing: 20){
                    Rectangle()
                        .fill(isSelected ? Color.nfl : .white)
                        .frame(width: 5)
                    
                    ZStack{
                        Image(systemName: imageName)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(isSelected ? .black : .gray)
                            .frame(width: 26, height: 26)
                    }
                    .frame(width: 30, height: 30)
                    Text(title)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(isSelected ? .black : .gray)
                    Spacer()
                }
            }
        }
        .frame(height: 50)
        .background(
            LinearGradient(colors: [isSelected ? Color.nfl.opacity(0.5) : .white, .white], startPoint: .leading, endPoint: .trailing)
        )
    }
}
