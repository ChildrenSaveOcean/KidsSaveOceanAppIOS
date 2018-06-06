//
//  KSOBaseSubView.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 5/25/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

class KSOBaseSubView: UIView {
    
    @IBOutlet weak var image: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialiaze()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialiaze()
    }
    
    private func initialiaze() {
        loadFromNib()
        image.imageView?.applyGradient()
        //layoutIfNeeded()
    }
}

