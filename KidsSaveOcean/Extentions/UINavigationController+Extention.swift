//
//  UINavigationController+Extention.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 11/6/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

extension UINavigationController {

    override open func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear
    }

}
