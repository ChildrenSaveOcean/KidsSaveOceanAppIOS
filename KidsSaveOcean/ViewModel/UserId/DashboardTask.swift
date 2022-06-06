//
//  DashboardTask.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 6/5/22.
//  Copyright © 2022 KidsSaveOcean. All rights reserved.
//

import Foundation

enum DashboardTask: Int, CaseIterable {
    case research, write_letter_about_plastic, write_letter_about_climate, share, local_politics, protest,  hijack_policy_selected, campaign

    var title: String {
        switch self {
        case .research:
            return "Research plastic & climate emergencies"
        case .share:
            return "Spread Fatechanger by sharing"
        case .local_politics:
            return "Help create new environmental laws"
        case .protest:
            return "Take part in or organize a protest"
        case .write_letter_about_plastic:
            return "Write your government a letter about plastic"
        case .write_letter_about_climate:
            return "Write your government a letter about climate"
        default:
            return ""
        }
    }
}
