//
//  NSLayoutConstraint+Extentions.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 1/16/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class KSOLayoutConstraint:NSLayoutConstraint {

    static let screenDimensionCorrectionFactor:CGFloat = UIScreen.main.bounds.height < 667 ? 2/3 : 1

   override var constant: CGFloat {
        set {
            super.constant *= KSOLayoutConstraint.screenDimensionCorrectionFactor
        }
        get {
            return super.constant*KSOLayoutConstraint.screenDimensionCorrectionFactor
        }
    }
}

extension NSLayoutConstraint {
 
}
