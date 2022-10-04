//
//  EnvironmentTableViewCell.swift
//  KidsSaveOcean
//
//  Created by Neha Mittal on 9/23/19.
//  Copyright © 2019 KidsSaveOcean. All rights reserved.
//

import UIKit

class EnvironmentTableViewCell: UITableViewCell {

    @IBOutlet weak var environmentImageView: UIImageView!
    @IBOutlet weak var environmentLabel: UILabel!
    @IBOutlet weak var playImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        environmentImageView.roundCorners()
    }

}
