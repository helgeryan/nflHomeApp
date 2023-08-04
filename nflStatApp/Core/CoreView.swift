//
//  CoreView.swift
//  nflStatApp
//
//  Created by Ryan Helgeson on 8/4/23.
//

import SwiftUI

struct CoreView: View {
    @Binding var presentSideMenu: Bool
    let backgroundColor: Color
    let content: AnyView
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HeaderView(presentSideMenu: $presentSideMenu)
                    
                    content
                }
            }.background(backgroundColor)
        }
    }
}
