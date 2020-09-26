//
//  UIFont+Extentions.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 9/25/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

extension UIFont {
  class var textStyle2: UIFont {
    return UIFont.systemFont(ofSize: 22.0, weight: .regular)
  }
  class var textStyle3: UIFont {
    return UIFont.systemFont(ofSize: 15.0, weight: .regular)
  }
  class var textStyle: UIFont {
    return UIFont.systemFont(ofSize: 11.0, weight: .semibold)
  }
    
    class var proSemiBold15: UIFont {
        return UIFont(name: "SFProText-Semibold", size: 15) ?? UIFont.systemFont(ofSize: 20)
    }
    
    class var proRegular15: UIFont {
        return UIFont(name: "SFProText-Regular", size: 15) ?? UIFont.systemFont(ofSize: 20)
    }
    
    class var proRegular20: UIFont {
        return UIFont(name: "SFProText-Regular", size: 15) ?? UIFont.systemFont(ofSize: 20)
    }
    
    class var proDisplaySemiBold15: UIFont {
        return UIFont(name: "SFProDisplay-Semibold", size: 15) ?? UIFont.systemFont(ofSize: 20)
    }
    
    class var proDisplaySemiBold20: UIFont {
        return UIFont(name: "SFProDisplay-Semibold", size: 20) ?? UIFont.systemFont(ofSize: 20)
    }
    
    class var proRegular11: UIFont {
        return UIFont(name: "SFProText-Regular", size: 11) ?? UIFont.systemFont(ofSize: 11)
    }
}
