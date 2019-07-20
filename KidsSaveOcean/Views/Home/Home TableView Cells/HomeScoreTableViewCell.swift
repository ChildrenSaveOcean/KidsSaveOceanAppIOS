//
//  HomeScoreTableViewCell.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 10/12/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

class HomeScoreTableViewCell: UITableViewCell, HomeTableViewCellProtocol, NotificationBadgeProtocol {
    
  @IBOutlet weak var country1NumLabel: UILabel!
  @IBOutlet weak var country1Label: UILabel!
  @IBOutlet weak var country1ScoreLabel: UILabel!
  @IBOutlet weak var country2NumLabel: UILabel!
  @IBOutlet weak var country2Label: UILabel!
  @IBOutlet weak var country2ScoreLabel: UILabel!
  @IBOutlet weak var country3NumLabel: UILabel!
  @IBOutlet weak var country3Label: UILabel!
  @IBOutlet weak var country3ScoreLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()

    country1NumLabel.text = ""
    country1Label.text = ""
    country1ScoreLabel.text = ""

    country2NumLabel.text = ""
    country2Label.text = ""
    country2ScoreLabel.text = ""

    country3NumLabel.text = ""
    country3Label.text = ""
    country3ScoreLabel.text = ""
  }
    
    func configure(with viewModel: AnyObject?) {
        let scores = CountriesService.shared().countriesContacts.filter({$0.letters_written > 0}).sorted { $0.letters_written > $1.letters_written}
        
        if scores.count > 0 {
            country1NumLabel.text = "1"
            country1Label.text = scores[0].name
            country1ScoreLabel.text = String( scores[0].letters_written )
        }
        
        if scores.indices.contains(1) {
            country2NumLabel.text = "2"
            country2Label.text = scores[1].name
            country2ScoreLabel.text = String( scores[1].letters_written )
        }
        
        if scores.indices.contains(2) {
            country3NumLabel.text = "3"
            country3Label.text = scores[2].name
            country3ScoreLabel.text = String( scores[2].letters_written )
        }
        
    }

}
