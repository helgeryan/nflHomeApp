//
//  DraftViewModel.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import SwiftUI

class DraftViewModel: ObservableObject {
    @Published var draft: DraftResponse?
    var year: Int = 2023
    init() {
        NFLService().getDraft(year: year, completion: { draft in
            self.draft = draft
        })
    }
    
    
}
