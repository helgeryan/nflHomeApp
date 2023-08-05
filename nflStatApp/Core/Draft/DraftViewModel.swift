//
//  DraftViewModel.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import SwiftUI

@MainActor
class DraftViewModel: ObservableObject {
    @Published var draft: DraftResponse?
    var year: Int = 2023
    init() {
        Task {
            if let draft = await NFLService().getDraft(year: year) {
                self.draft = draft
            }
        }
    }
}
