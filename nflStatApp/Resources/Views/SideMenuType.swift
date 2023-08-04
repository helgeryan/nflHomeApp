//
//  SideMenuType.swift
//  tcrp
//
//  Created by Ryan Helgeson on 7/24/23.
//

enum SideMenuRowType: Int, CaseIterable {
    case home = 0
    case draft
    case freeAgents
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .draft:
            return "Draft Recap"
        case .freeAgents:
            return "Schedule"
        }
    }
    
    var iconName: String {
        switch self {
        case .home:
            return "house"
        case .draft:
            return "figure.american.football"
        case .freeAgents:
            return "clipboard"
        }
    }
}
