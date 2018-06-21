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
    
    var orientation:ViewOrientation
    
    init(_ v:ViewOrientation) {
        self.orientation = v
        super.init(frame:CGRect.zero)
        initialiaze()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.orientation = .vertical
        super.init(coder: aDecoder)
        initialiaze()
    }
    
    private func initialiaze() {
        loadFromNib()
        
        let viewWidth = UIScreen.main.bounds.width - 2*kStandardViewGap
        let ratio = (orientation == .horisontal) ? 0.6 : image.frame.height/image.frame.width // TODO avoid 0.6
        
        frame = CGRect(x:0, y:0, width:viewWidth, height:viewWidth*ratio)
        
        widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        heightAnchor.constraint(equalToConstant: viewWidth*ratio).isActive = true
        
        for subView in subviews[0].subviews {
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        layoutIfNeeded()
        
        image.backgroundColor = UIColor.backgroundGray
        image.imageView?.applyGradient()
    }
    
}
