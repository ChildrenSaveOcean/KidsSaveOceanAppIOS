//
//  HijackPolicy.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 10/7/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import Foundation

struct HijackPolicy: Codable {

    enum CodingKeys: String, CodingKey {
        case description, summary, votes
    }

    var id: String = ""
    let description: String
    let summary: String
    var votes: Int
    
    mutating func updateVotes(to value: Int) {
        self.votes = value
    }
}
