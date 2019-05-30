//
//  KSOTemporaryData.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 6/2/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

typealias KSODataDictionary = [String: Any]

struct MainViewData {
    let image: UIImage
    let title: String
    let subTitle: String
    let decription: String

    init?(dictionary: KSODataDictionary) {
        if
            let imageNew = dictionary["image"] as? UIImage,
            let titleStr = dictionary["title"] as? String,
            let subTitleStr = dictionary["subTitle"] as? String,
            let descriptionStr = dictionary["description"] as? String {
                self.image = imageNew
                self.title = titleStr
                self.subTitle = subTitleStr
                self.decription = descriptionStr
            } else {
                return nil
            }
    }
}

struct NewsViewData {

}

struct NewsTableViewData {

}

class KSOTemporaryData: NSObject {

}
