//
//  KSOMediaViewController.swift
//  KidsSaveOcean
//
//  Created by Renata on 06/06/2018.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit


//Need to modify main storyboard to test it
class KSOMediaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storedPictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mediaCollectionView.dequeueReusableCell(withIdentifier: "mediaCell", for: indexPath) as! KSOMediaTableViewCell
        return cell
    }
    
    
    //for example, I will use random images
    private var storedPictures = [#imageLiteral(resourceName: "Turtle"), #imageLiteral(resourceName: "Whale"), #imageLiteral(resourceName: "WhaleTail"), #imageLiteral(resourceName: "Reef"), #imageLiteral(resourceName: "actinia"), #imageLiteral(resourceName: "Whale"), #imageLiteral(resourceName: "WhaleTail"), #imageLiteral(resourceName: "Reef"), #imageLiteral(resourceName: "actinia"), #imageLiteral(resourceName: "Whale"), #imageLiteral(resourceName: "WhaleTail"), #imageLiteral(resourceName: "Reef"), #imageLiteral(resourceName: "actinia")]
    
    @IBOutlet weak var mediaCollectionView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //registering my cell to use in table view
        mediaCollectionView.register(UINib(nibName: "KSOMediaTableViewCell", bundle: nil), forCellReuseIdentifier: "mediaCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mediaCollectionView.estimatedRowHeight = 100
        mediaCollectionView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
