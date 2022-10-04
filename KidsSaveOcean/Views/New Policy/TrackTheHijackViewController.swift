//
//  TrackTheHijackViewController.swift
//  KidsSaveOcean
//
//  Created by Neha Mittal on 9/17/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class TrackTheHijackViewController: UIViewController, Instantiatable {
    
    @IBAction func spreadButton(_ sender: Any) {
        ShareKidsSaveOcean.share(target: self)
    }

}
