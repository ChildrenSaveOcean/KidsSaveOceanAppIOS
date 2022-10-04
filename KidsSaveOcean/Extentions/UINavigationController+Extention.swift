//
//  UINavigationController+Extention.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 11/6/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

extension UINavigationController {

    var statusBarTag: Int { return 100500 }

    override open func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .clear

        navigationBar.tintColor = UIColor.kidsSaveOceanBlue //UIColor.init(named: "KidSaveOcean Blue")

        navigationBar.standardAppearance.backgroundColor = .clear
        navigationBar.standardAppearance.backgroundEffect = .none
        navigationBar.standardAppearance.shadowColor = .clear

        let statusBarFrame = UIApplication.shared.statusBarFrame
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.tag = statusBarTag
        self.view.addSubview(statusBarView)
    }

    func setStatusBarColor(_ color: UIColor) {
        self.view.subviews.filter{ $0.tag == statusBarTag }.first?.backgroundColor = color
    }

}
