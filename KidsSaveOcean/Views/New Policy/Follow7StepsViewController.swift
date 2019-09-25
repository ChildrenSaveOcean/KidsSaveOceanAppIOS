//
//  Follow7StepsViewController.swift
//  KidsSaveOcean
//
//  Created by Neha Mittal on 9/17/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class Follow7StepsViewController: UIViewController, Instantiatable {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
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

extension Follow7StepsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StepsTableViewCell", for: indexPath) as? StepsTableViewCell else { fatalError("Wrong cell type. There is expected StepsTableViewCell") }
        
        var textTitle = ""
        
        switch indexPath.row {
        case 0:
            textTitle = "Watch the video about the ballot process to understand how it works."
        case 1:
            textTitle = "Vote on which policy you want passed."
        case 2:
            textTitle = "After kids decide, you’ll be notified. Check out the policy, then enter in the app how many signatures you plan to collect."
        case 3:
            textTitle = "Download and print the signature collection paper. Begin collecting. Share."
        case 4:
            textTitle = "As you collect signatures, keep them updated - see how many we need."
        case 5:
            textTitle = "We can’t do this alone; we must recruit other organizations to help - kids will lead, adults will follow. Tell your local newspaper,  environmental groups, your friends!"
        default:
            textTitle = "You’ll be notified when and where to mail your signature papers."
        }
        
        cell.numberLabel.text = "\(indexPath.row + 1)"
        cell.textDescLabel.text = textTitle
        return cell
        
    }
}


import UIKit

extension UIImageView {
    
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
    }
}
