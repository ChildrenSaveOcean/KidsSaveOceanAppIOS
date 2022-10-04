//
//  CGFloat+Extentions.swift
//  KidsSaveOcean
//
//  Created by Renata Faria on 16/09/2018.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {

    static var random: CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
