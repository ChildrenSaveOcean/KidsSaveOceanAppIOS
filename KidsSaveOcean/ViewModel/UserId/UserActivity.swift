//
//  UserActivity.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 1/23/22.
//  Copyright © 2022 KidsSaveOcean. All rights reserved.
//

import UIKit

struct UserActivity: Codable {

    enum CodingKeys: String, CodingKey {
        case local_politics = "dash_joined_a_policy_hijack_campaign"
        case research = "dash_learn_about_problem"
        case protest = "dash_protest"
        case share = "dash_share"
        
        case write_letter_about_climate = "dash_wrote_a_letter_about_climate"
        case write_letter_about_plastic = "dash_wrote_a_letter_about_plastic"

        case letters_written = "user_letters_written"
        case user_type = "user_person_type"
        case hijack_policy_selected = "hijack_policy_selected"
        case signatures_pledged = "signatures_pledged"
        case location_id = "location_id"
    }

    var local_politics: Bool = false
    var research: Bool = false
    var protest: Bool = false
    var share: Bool = false
    var start_campaign: Bool = false
    var write_letter_about_climate: Bool = false
    var write_letter_about_plastic: Bool = false
    var letters_written: Int = 0
    var user_type: UserType = .student
    var hijack_policy_selected: String = ""
    var signatures_pledged: Int = 0
    var location_id: String = ""
    var campaign: CampaignSignatures? = CampaignSignatures(campaing: [String: Any]())
    var userType: UserType = .other

}
