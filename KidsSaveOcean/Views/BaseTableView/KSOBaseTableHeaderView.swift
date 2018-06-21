//
//  KSOBaseTableHeaderView.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 6/12/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

class KSOBaseTableHeaderView: UIView {
    
    let headerTitle:UILabel = { () -> UILabel in
        let title = UILabel()
        
        // set font, size, color, etc
        title.textColor = UIColor.black
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    fileprivate func initialize() {
        self.addSubview(headerTitle)
        var titleFrame = frame
        titleFrame.origin.x = kStandardViewGap
        headerTitle.frame = titleFrame
        
        backgroundColor = UIColor.white
        clipsToBounds = true
        layer.cornerRadius = kStandardCornerRadius
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    
    //// TODO refactor it
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.origin.x += kStandardViewGap
            frame.size.width -= 2 * kStandardViewGap
            super.frame = frame
        }
    }
}

