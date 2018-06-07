//
//  KSOMediaViewController.swift
//  KidsSaveOcean
//
//  Created by Renata on 06/06/2018.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit


//Need to modify main storyboard to test it
class KSOMediaViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //for example, I will use random images
    private var storedPictures = [#imageLiteral(resourceName: "Turtle"), #imageLiteral(resourceName: "Whale"), #imageLiteral(resourceName: "WhaleTail"), #imageLiteral(resourceName: "Reef"), #imageLiteral(resourceName: "actinia")]
    
    @IBOutlet weak var mediaCollectionView : UICollectionView!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       //create an array of stored pictures and return the count of it
        let numberOfStoragePicture = storedPictures.count
        return numberOfStoragePicture
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mediaCollectionView.dequeueReusableCell(withReuseIdentifier: "mediaCell", for: indexPath) as! KSOMediaCollectionViewCell
        cell.imgMedia.image = storedPictures[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSize = (collectionView.frame.size.width / 2) - 2.5 // 2.3 is equal to the half of space between cell 
        
        //here need to put numbers to change the size of the cells
        return CGSize(width:cellSize , height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //space between cells (vertical)
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        //space between cells (horizontal)
        return 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //registering my cell to use in table view
        mediaCollectionView.register(UINib(nibName: "KSOMediaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "mediaCell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
}
