//
//  NotificationItem.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 7/20/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import Foundation

struct  NotificationItem: Equatable {
    var target: NotificationTarget = .unknown
    var expirationDate: Date?
    var link: String?
    var id: String
    
    init(id: String, target: NotificationTarget, link: String?, expirationDate: Date?) {
        self.id = id
        self.target = target
        self.link = link
        self.expirationDate = expirationDate
    }
}
