//
//  KSOBaseTableViewCell.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 5/28/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

class KSOBaseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tableViewTitle: UILabel!
    @IBOutlet weak var tableViewSubTitle: UILabel!
    @IBOutlet weak var tableViewIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func makeRoundIcon() {
        tableViewIcon.layer.cornerRadius = tableViewIcon.frame.height/2
        tableViewIcon.clipsToBounds = true
    }
    
    //// TODO refactor it
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.origin.x += kStandardViewGap
            frame.size.width -= 2 * kStandardViewGap
            super.frame = frame
        }
    }
    
}

