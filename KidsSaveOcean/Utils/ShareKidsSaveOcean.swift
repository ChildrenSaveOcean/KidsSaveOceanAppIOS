//
//  ShareKidsSaveOcean.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 11/23/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class ShareKidsSaveOcean {
    static func share(target: UIViewController) {
        share(target: target, completion: nil)
    }
    
    static func share(target: UIViewController, completion: (() -> Void)?) {
        let linkForSharing = "https://www.kidssaveocean.com/change-fate"
        let objectsToShare = [URL(string: linkForSharing) as Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        target.present(activityVC, animated: true) {
            completion?()
        }
    }
}
