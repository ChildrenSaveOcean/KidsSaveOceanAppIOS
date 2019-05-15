//
//  HomeScoreTableViewCell.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 10/12/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

class HomeScoreTableViewCell: UITableViewCell {

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

}
