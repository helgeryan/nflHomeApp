//
//  HeirarchyViewModel.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import SwiftUI

@MainActor
class HeirarchyViewModel: ObservableObject {
    @Published var heirarchy: HeirarchyResponse?
    init() {
        Task {
            if let heir = await NFLService().getHeirarchy() {
                self.heirarchy = heir
            }
        }
    }
}

