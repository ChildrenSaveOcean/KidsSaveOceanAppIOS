//
//  NotificationTarget.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 7/20/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import Foundation

enum NotificationTarget: String, CaseIterable, Codable {

    case
    unknown = " ",
    actionAlert = "ActionAlert",
    policyChange = "PolicyChange",
    newsAndMedia = "NewsAndMedia",
    newHighScore = "NewHighScore",
    signatureCampaign = "SignatureCampaign"
    
    func decsription() -> String {
        return self.rawValue
    }
    
    static func getTargetFromString(_ string: String?) -> NotificationTarget {

        return NotificationTarget.allCases.filter({ (notificationTarget) -> Bool in
            notificationTarget.decsription() == string
        }).first ?? .unknown
    }
    
}
