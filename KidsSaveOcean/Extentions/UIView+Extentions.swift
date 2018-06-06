//
//  UIView+Extentions.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 5/24/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    
    func scaleConstraint() -> () {
        guard UIScreen.main.bounds.width == 640.0 else {
            return
        }
        
        let newValue = self.constant * 0.7
        self.constant = newValue
    }
    
}

extension UIView {
   
    @discardableResult
    func loadFromNib<T : UIView>() -> T? {
        
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            return nil
        }
        self.addSubview(contentView)
        
        contentView.frame = self.bounds
        if (contentView.frame.height > 0) {
            contentView.layoutIfNeeded()
        }
        
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
    
}

extension UIStackView {
    
    func applyToScrollView(_ scrollView:UIScrollView) {
        
        axis = UILayoutConstraintAxis.vertical
        distribution = UIStackViewDistribution.fillEqually
        alignment = UIStackViewAlignment.center
        spacing = 10.0
        translatesAutoresizingMaskIntoConstraints = false
        
        widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        
        layoutIfNeeded()
    }
    
    
}

