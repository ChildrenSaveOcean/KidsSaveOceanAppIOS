//
//  HomeTableViewCell.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 9/25/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell, HomeTableViewCellProtocol, NotificationBadgeProtocol {

  @IBOutlet weak var imageCover: UIImageView!
  @IBOutlet weak var subTitleLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!

    func configure(with viewModel: AnyObject?) {
        guard let viewModel = viewModel as? BaseTableViewData else {return}
        
        imageCover.image =  viewModel.image
        titleLabel.text = viewModel.title
        titleLabel.textColor = UIColor.backgroundWhite
        subTitleLabel.text = viewModel.subTitle
        subTitleLabel.textColor = UIColor.backgroundWhite
    }
    
    func setDarkLetters() {
        titleLabel.textColor = .black
        subTitleLabel.textColor = .black
    }
}
