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
        // Initialization code
        imageRoundedView.setRounded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
