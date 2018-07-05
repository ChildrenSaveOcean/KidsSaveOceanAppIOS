//
//  KSOMediaTableViewCell.swift
//  KidsSaveOcean
//
//  Created by Renata on 03/07/2018.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

class KSOMediaTableViewCell: UITableViewCell {

    @IBOutlet weak var newsAndMediasContentView: UIView!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var lblPostComment: UILabel!
    @IBOutlet weak var lblComentAuthorNickName: UILabel!
    
    @IBOutlet weak var lblComentAuthor: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
            newsAndMediasContentView.sizeToFit()
            newsAndMediasContentView.layoutIfNeeded()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
