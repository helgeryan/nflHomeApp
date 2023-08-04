//
//  DraftViewModel.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import SwiftUI

class DraftViewModel: ObservableObject {
    @Published var draft: DraftResponse?
    init() {
        NFLService().getDraft(completion: { draft in
            self.draft = draft
        })
    }
    
    
}
