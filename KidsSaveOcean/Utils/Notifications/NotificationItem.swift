//
//  NotificationItem.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 7/20/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import Foundation

class NotificationItem: NSObject, NSCoding { //, Equatable
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
    
    required convenience init?(coder decoder: NSCoder) {

        guard let id = decoder.decodeObject(forKey: "id") as? String else { return nil }
        guard let targetString = decoder.decodeObject(forKey: "target") as? String else { return nil }
        let target = NotificationTarget.getTargetFromString(targetString)
        let link = decoder.decodeObject(forKey: "link") as? String
        let expirationDate = decoder.decodeObject(forKey: "expirationDate") as? Date
        self.init(id: id, target: target, link: link, expirationDate: expirationDate)
    }
    
    func encode(with aCoder: NSCoder) {

        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.expirationDate, forKey: "expirationDate")
        aCoder.encode(self.link, forKey: "link")
        aCoder.encode(self.target.decsription(), forKey: "target")
    }
}
