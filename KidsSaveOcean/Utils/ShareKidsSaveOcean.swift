//
//  ShareKidsSaveOcean.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 11/23/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class ShareKidsSaveOcean {
    static func share(target: UIViewController, text: String = "") {
        share(target: target, text: text, completion: nil)
    }
    
    static func share(target: UIViewController, text: String = "", completion: (() -> Void)?) {
        let textForSharing = text.isEmpty ? "Check out this FateChanger app - we’re going to take back the future:\n" : text
        let linkForSharing = "https://www.kidssaveocean.com/change-fate"
        let objectsToShare = [textForSharing as Any, URL(string: linkForSharing) as Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        target.present(activityVC, animated: true) {
            completion?()
        }
    }
}
