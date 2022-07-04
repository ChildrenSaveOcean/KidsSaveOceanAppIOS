//
//  KSODataStructures.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 6/2/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

struct BaseViewData: Codable {

    enum CodingKeys: String, CodingKey {
        case image_name, title, subTitle, decription, action
    }

    let image_name: String
    let title: String
    let subTitle: String
    let decription: String
    let action: String

    lazy var image = UIImage(named: image_name)
}

struct BaseTableViewData: Codable {

    enum CodingKeys: String, CodingKey {
        case image_name, title, subTitle
    }

    let image_name: String?
    let title: String
    let subTitle: String

    var image: UIImage? {
        guard let name = image_name else { return nil }
        return UIImage(named: name)
    }
}

class KSOStaticDataStructures: NSObject {

}
