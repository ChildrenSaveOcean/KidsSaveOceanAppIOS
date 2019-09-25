//
//  YouthInitiativeProcessViewController.swift
//  KidsSaveOcean
//
//  Created by Neha Mittal on 9/17/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class YouthInitiativeProcessViewController: UIViewController, Instantiatable {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

extension YouthInitiativeProcessViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EnvironmentCell", for: indexPath) as? EnvironmentTableViewCell else { fatalError("Wrong cell type. There is expected EnvironmentTableViewCell") }
        
        var textTitle = ""
        var imageName = ""
        cell.environmentLabel.textColor = .white
        
        switch indexPath.row {
        case 0:
            textTitle = "How does it work?"
            imageName = "How"
        case 1:
            textTitle = "Follow these 7 Steps"
            imageName = "Follow"
        case 2:
            textTitle = "Vote now on a policy we'll push"
            imageName = "Vote"
        case 3:
            textTitle = "Sing Up and update signatures"
            imageName = "SignUp"
        case 4:
            textTitle = "Multiply your Impact"
            imageName = "Multiply"
        case 5:
            guard let trackCell = tableView.dequeueReusableCell(withIdentifier: "TrackTableViewCell", for: indexPath) as? TrackTableViewCell else { fatalError("Wrong cell type. There is expected TrackTableViewCell")}
            //            cell.environmentLabel.textColor = .black
            //            textTitle = "Track the hijack"
            //            imageName = "Track"
            return trackCell
        default:
            textTitle = ""
            imageName = ""
        }
        
        //        cell.environmentLabel.text = textTitle
        cell.environmentImageView.image = UIImage(named: imageName)
        return cell
        
    }
}
