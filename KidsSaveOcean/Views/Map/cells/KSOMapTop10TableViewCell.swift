//
//  MapTop10TableViewCell.swift
//  KidsSaveOcean
//
//  Created by Renata Faria on 16/09/2018.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

class KSOMapTop10TableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewNumber: UIView!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var lblNumberOfLetters: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewNumber.layer.cornerRadius = self.viewNumber.frame.size.height / 2
        self.viewNumber.backgroundColor = UIColor.random
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
