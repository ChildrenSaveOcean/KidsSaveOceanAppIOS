//
//  KSOHomeViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 7/16/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

class KSOHomeViewController: KSOBaseViewController {
    
    override func viewDidLoad() {
        subViewsData = KSOHomeViewData
        super.viewDidLoad()
    }
    
    override func createSubView(_ subViewF: KSODataDictionary, orientation: ViewOrientation) -> (KSOBaseSubView) {
        let subView = super.createSubView(subViewF, orientation: .horisontal)
        subView.subTitleLabel.textColor = .white
        return subView
    }
    
    override func touchView(_ actionString: String) {
        print("There will be action on touch")
    }
}
