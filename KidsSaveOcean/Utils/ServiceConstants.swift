//
//  ServerPath.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 9/28/23.
//  Copyright © 2023 KidsSaveOcean. All rights reserved.
//

import Foundation

let ServerPathBase = "pederhill.wixsite.com/kids-save-ocean/"

enum ServerPath: String {

    case change_fate = "change-fate",
         hijackpolicy, projects, studentresources, dashboardtutorial,
         action_alert = "action-alert",
         copy_of_write_letters_with_your_kid = "copy-of-write-letters-with-your-kid",
         sharelikeaboss, updates, 
         fatechanger_resources = "fatechanger-resources",
         fatechangeryouthintro,
         video_test = "video-test"

    var string: String {
        return "https://" + ServerPathBase + self.rawValue
    }
}
