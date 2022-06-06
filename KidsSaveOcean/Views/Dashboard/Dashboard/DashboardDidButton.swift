//
//  DashboardDidButton.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 9/10/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class DashboardDidButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        self.titleLabel?.numberOfLines = 0
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.textColor = .white
        self.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        self.titleLabel?.alpha = 0 // or the text get blinking for moment but it is noticable
        
        guard let titleLength = title?.count else {return}
        self.titleLabel?.font = self.titleLabel?.font.withSize(titleLength > 10 ? 9 : 16)
        super.setTitle(title, for: state)
        
        self.titleLabel?.alpha = 1
    }

}
