//
//  KSOMediaViewController.swift
//  KidsSaveOcean
//
//  Created by Renata on 06/06/2018.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit


//Need to modify main storyboard to test it
class KSONewsAndMediaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storedPictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mediaTableView.dequeueReusableCell(withIdentifier: "mediaCell", for: indexPath) as! KSOMediaTableViewCell
        cell.lblComment.text! = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        cell.lblPostComment.text! = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque aliquam tincidunt velit ac placerat. Nunc viverra consectetur neque quis iaculis. Vestibulum fringilla viverra justo eu dapibus. Nulla facilisi. Quisque porta efficitur enim in posuere. Morbi et semper neque. Morbi rutrum vel nisi eu accumsan."
        return cell
    }
    
    
    //for example, I will use random images
    private var storedPictures = [#imageLiteral(resourceName: "Turtle"), #imageLiteral(resourceName: "Whale"), #imageLiteral(resourceName: "turtleInNet"), #imageLiteral(resourceName: "deadBird"), #imageLiteral(resourceName: "surferOnWave"), #imageLiteral(resourceName: "Whale"), #imageLiteral(resourceName: "turtleInNet"), #imageLiteral(resourceName: "deadBird"), #imageLiteral(resourceName: "surferOnWave"), #imageLiteral(resourceName: "Whale"), #imageLiteral(resourceName: "deadBird"), #imageLiteral(resourceName: "turtleInNet"), #imageLiteral(resourceName: "surferOnWave")]
    
    @IBOutlet weak var mediaTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //registering my cell to use in table view
        mediaTableView.register(UINib(nibName: "KSOMediaTableViewCell", bundle: nil), forCellReuseIdentifier: "mediaCell")
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        //#MARK:TODO: Fix the automatic size of cells
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
