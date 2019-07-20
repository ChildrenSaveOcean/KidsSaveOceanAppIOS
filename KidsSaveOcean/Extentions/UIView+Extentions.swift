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

let kStandardViewGap: CGFloat      = 15
let kStandardCornerRadius: CGFloat = 10
let kStandardTableHeaderHeight: CGFloat = 40

extension UIView {

    @discardableResult
    func loadFromNib<T: UIView>() -> T? {

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

    func roundCornersWith(_ radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    func addRedBadge(with num: Int) {
        
        let r: CGFloat = 10
        let frame = CGRect(x: self.frame.width - 3*r, y: r/2, width: 2*r, height: 2*r)
        let circleView = UIView(frame: frame)
        circleView.backgroundColor = .red
        circleView.roundCornersWith(r)
        
        let numLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 2*r, height: 2*r))
        numLabel.textColor = .white
        numLabel.textAlignment = .center
        numLabel.text = String(num)
        
        circleView.addSubview(numLabel)
        circleView.restorationIdentifier = notificationBadgeId
        self.addSubview(circleView)
    }

    func blinkOpacity(times: Float) {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.duration = 0.2
        animation.fromValue = 1
        animation.toValue =  0.2
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.autoreverses = true
        animation.repeatCount = times
        layer.add(animation, forKey: nil)
    }
    
    func blinkBackColor(times: Float) {
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        let startColor = backgroundColor?.cgColor ?? UIColor.clear.cgColor
        animation.fromValue = startColor
        animation.toValue = UIColor.appCyan.cgColor 
        animation.duration = 0.2
        animation.repeatCount = times
        layer.add(animation, forKey: "colourAnimation")
        layer.backgroundColor = startColor
    }
}
