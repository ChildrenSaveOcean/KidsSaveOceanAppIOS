//
//  UIAlertAction+Extensions.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 5/13/20.
//  Copyright © 2020 KidsSaveOcean. All rights reserved.
//

import UIKit

extension UIAlertAction {
    func setAppTextColor() {
        self.setValue(UIColor.kidsSaveOceanBlue, forKey: "titleTextColor")
    }
}
