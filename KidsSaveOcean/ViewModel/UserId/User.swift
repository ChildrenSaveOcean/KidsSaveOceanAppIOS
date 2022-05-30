//
//  User.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 5/18/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

enum UserType: Int, Codable { // we can get from from Firebase, bit it will stay here temporary
    case
    student,
    teacher,
    other
}

struct User: Codable {
    var type: UserType

    init(type: UserType) {
        self.type = type
    }
}
