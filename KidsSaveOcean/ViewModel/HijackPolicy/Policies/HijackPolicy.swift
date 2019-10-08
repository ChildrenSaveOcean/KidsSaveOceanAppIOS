//
//  HijackPolicy.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 10/7/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import Foundation

struct HijackPolicy {
    let id: String
    let description: String
    let summary: String
    var votes: Int
    
    init(id: String, description: String, summary: String, votes: Int? ) {
        self.id = id
        self.description = description
        self.summary = summary
        self.votes = votes ?? 0
    }
    
    mutating func updateVotes(to value: Int) {
        self.votes = value
    }
}
