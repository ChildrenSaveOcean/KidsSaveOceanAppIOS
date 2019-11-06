//
//  TrackTheHijackViewController.swift
//  KidsSaveOcean
//
//  Created by Neha Mittal on 9/17/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class TrackTheHijackViewController: UIViewController, Instantiatable {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func spreadButton(_ sender: Any) {
        let linkForSharing = "https://www.kidssaveocean.com/change-fate"
        let objectsToShare = [URL(string: linkForSharing) as Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        self.present(activityVC, animated: true) {
            //
        }
    }

}
