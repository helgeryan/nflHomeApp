//
//  HeirarchyViewModel.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import SwiftUI

class HeirarchyViewModel: ObservableObject {
    @Published var heirarchy: HeirarchyResponse?
    init() {
        NFLService().getHeirarchy(completion: { heirarchy in
            self.heirarchy = heirarchy
        })
    }
}

