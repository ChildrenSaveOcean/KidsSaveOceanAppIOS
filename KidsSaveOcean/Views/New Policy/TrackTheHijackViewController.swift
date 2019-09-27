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
        let linkForSharing = "Some text"
        let objectsToShare = [URL(string: linkForSharing) as Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        self.present(activityVC, animated: true) {
//             self.chooseTaskWithNum(2)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
