//
//  KSODataStructures.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 6/2/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

struct BaseViewData {
    
    let image:UIImage
    let title:String
    let subTitle:String
    let decription:String
    let action:String
    
    init?(dictionary: KSODataDictionary) {
        if
            let imageNew = dictionary["image"] as? UIImage,
            let titleStr = dictionary["title"] as? String,
            let subTitleStr = dictionary["subTitle"] as? String,
            let descriptionStr = dictionary["description"] as? String,
            let actionStr = dictionary["action"] as? String {
            self.image = imageNew
            self.title = titleStr
            self.subTitle = subTitleStr
            self.decription = descriptionStr
            self.action = actionStr
        } else {
            return nil
        }
    }
}

struct BaseTableViewData {
    let image:UIImage?
    let title:String
    let subTitle:String
    
    init?(dictionary: KSODataDictionary) {
        
        var imageNew:UIImage?
        if ((dictionary["image"]) != nil) {
            imageNew = dictionary["image"] as? UIImage
        }
        
        if
            //let imageNew = dictionary["image"] as? UIImage, /// TODO, the same question
            let titleStr = dictionary["title"] as? String,
            let subTitleStr = dictionary["subTitle"] as? String {
            self.image = imageNew
            self.title = titleStr
            self.subTitle = subTitleStr
        } else {
            return nil
        }
    }
}

class KSOStaticDataStructures: NSObject {
    
}

