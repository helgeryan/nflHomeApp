//
//  HeaderView.swift
//  tcrp
//
//  Created by Ryan Helgeson on 7/26/23.
//

import SwiftUI

struct HeaderView: View {
    @Binding var presentSideMenu: Bool
    
    var body: some View {
            HStack {
                Button {
                    presentSideMenu.toggle()
                } label: {
                    Image(systemName: "text.justify")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color(.gray))
                        .frame(width: 25, height: 25, alignment: .leading)
                    
                }
                Spacer()
            }.padding()
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(presentSideMenu: .constant(false))
    }
}
