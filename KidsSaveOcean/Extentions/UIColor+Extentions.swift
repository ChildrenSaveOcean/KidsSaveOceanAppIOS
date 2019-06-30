//
//  UIColor+Extentions.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 6/20/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

extension UIColor {

    class var backgroundGray: UIColor {
        return UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1.0)
    }

    static var random: UIColor {
        return UIColor(red: .random, green: .random, blue: .random, alpha: 1.0)
    }
  @nonobjc class var macaroniAndCheese: UIColor {
    return UIColor(red: 239.0 / 255.0, green: 182.0 / 255.0, blue: 42.0 / 255.0, alpha: 1.0)
  }
    
    @nonobjc class var appCyan: UIColor {
        return UIColor(red: 132 / 255.0, green: 215 / 255.0, blue: 220 / 255.0, alpha: 1.0)
    }
}
