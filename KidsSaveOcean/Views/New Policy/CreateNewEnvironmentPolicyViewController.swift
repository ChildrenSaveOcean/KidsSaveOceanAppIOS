//
//  CreateNewEnvironmentPolicyViewController.swift
//  KidsSaveOcean
//
//  Created by Neha Mittal on 9/16/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class CreateNewEnvironmentPolicyViewController: UIViewController, Instantiatable {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = .backgroundWhite
    }

}

extension CreateNewEnvironmentPolicyViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
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
            cell.playImageView.isHidden = false
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
            return trackCell
        default:
            textTitle = ""
            imageName = ""
        }
        
        cell.environmentLabel.text = textTitle
        cell.environmentImageView.image = UIImage(named: imageName)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let taskViewController = YouthInitiativeProcessViewController.instantiate()
            taskViewController.title = ""
            navigationController?.pushViewController(taskViewController, animated: true)
        case 1:
            let taskViewController = Follow7StepsViewController.instantiate()
            taskViewController.title = ""
            navigationController?.pushViewController(taskViewController, animated: true)
        case 2:
            let taskViewController = VoteNowViewController.instantiate()
            taskViewController.title = ""
            navigationController?.pushViewController(taskViewController, animated: true)
        case 3:
            let taskViewController = SignUpUpdateViewController.instantiate()
            taskViewController.title = ""
            navigationController?.pushViewController(taskViewController, animated: true)
        case 4:
            let taskViewController = MultiplympactViewController.instantiate()
            taskViewController.title = ""
            navigationController?.pushViewController(taskViewController, animated: true)
        case 5:
            let liveCampaign = UserViewModel.shared().isUserLocationCampaignIsLive()
            let taskViewController = liveCampaign ? TrackTheHijackLiveCampaignViewController.instantiate() : TrackTheHijackViewController.instantiate()
            taskViewController.title = ""
            navigationController?.pushViewController(taskViewController, animated: true)
        default:
            let taskViewController = YouthInitiativeProcessViewController.instantiate()
            taskViewController.title = ""
            navigationController?.pushViewController(taskViewController, animated: true)
        }
    }
}
