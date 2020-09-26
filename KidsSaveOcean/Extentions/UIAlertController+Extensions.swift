//
//  UIAlertController+Extensions.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 5/13/20.
//  Copyright © 2020 KidsSaveOcean. All rights reserved.
//

import UIKit

extension UIAlertController {

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for action in self.actions {
            action.setValue(UIColor.kidsSaveOceanBlue, forKey: "titleTextColor")
        }
    }
}
