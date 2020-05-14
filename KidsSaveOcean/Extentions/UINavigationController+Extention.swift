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

        navigationBar.tintColor = UIColor.appCyan //UIColor.init(named: "KidSaveOcean Blue")
        
         if #available(iOS 13.0, *) {
            //navigationBar.standardAppearance.backButtonAppearance.bac
             navigationBar.standardAppearance.backgroundColor = .clear
             navigationBar.standardAppearance.backgroundEffect = .none
             navigationBar.standardAppearance.shadowColor = .clear
         }
    }

}
