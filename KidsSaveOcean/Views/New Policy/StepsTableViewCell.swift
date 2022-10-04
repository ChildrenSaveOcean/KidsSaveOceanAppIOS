//
//  StepsTableViewCell.swift
//  KidsSaveOcean
//
//  Created by Neha Mittal on 9/24/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class StepsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var textDescLabel: UILabel!
    @IBOutlet weak var imageRoundedView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageRoundedView.roundCornersWith(imageRoundedView.bounds.width/2)
    }

}
