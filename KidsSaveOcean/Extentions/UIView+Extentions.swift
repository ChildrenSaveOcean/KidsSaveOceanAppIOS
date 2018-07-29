//
//  UIView+Extentions.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 5/24/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

enum ViewOrientation {
    case horisontal
    case vertical
}

let StandardViewGap: CGFloat = 15
let StandardCornerRadius: CGFloat = 10
let StandardTableHeaderHeight: CGFloat = 40

extension UIView {
    
    @discardableResult
    func loadFromNib<T : UIView>() -> T? {
        
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            return nil
        }
        self.addSubview(contentView)
        
        contentView.frame = self.bounds
        
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.translatesAutoresizingMaskIntoConstraints = true
        
        for subView in contentView.subviews {
            subView.autoresizingMask = contentView.autoresizingMask
            subView.translatesAutoresizingMaskIntoConstraints = contentView.translatesAutoresizingMaskIntoConstraints
        }
        
        return contentView
    }
    
    func applyGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor,
                           UIColor.black.cgColor]
        
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.opacity = 0.7
        
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func roundCorners() {
        roundCornersWith(10)
    }
    
    func roundCornersWith(_ radius:CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
}
