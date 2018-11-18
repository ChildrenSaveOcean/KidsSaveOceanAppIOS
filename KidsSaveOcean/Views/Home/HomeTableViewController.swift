//
//  HomeTableViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 9/25/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

  private let homeCellIdenteficator = "homeViewCellIdentificator"
  private let scoreCellIdenteficator = "scoreViewCellIdentificator"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.backgroundColor = UIColor.backgroundGray
    tableView.isScrollEnabled = true
    tableView.bounces = false
    tableView.isUserInteractionEnabled = true
    tableView.separatorStyle = .none
    tableView.separatorColor = UIColor.backgroundGray
    tableView.showsVerticalScrollIndicator = false
    tableView.rowHeight = view.bounds.height * 156/667 // (for keeping design proportions iPhone8 for cell)
    tableView.dataSource = self
    tableView.delegate   = self
    
    print ("view bounds are \(view.bounds)")
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return HomeViewData.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let staticData = BaseTableViewData(dictionary: HomeViewData[indexPath.row])
    if indexPath.row == 3 {
      let cell = tableView.dequeueReusableCell(withIdentifier: scoreCellIdenteficator, for: indexPath) as! HomeTableViewCell
      
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: homeCellIdenteficator, for: indexPath) as! HomeTableViewCell
      cell.imageCover.image =  staticData?.image
      cell.titleLabel.text = staticData?.title
      cell.subTitleLabel.text = staticData?.subTitle
      
      if indexPath.row == 2 { // TODO: need a better way
        cell.titleLabel.textColor = .black
        cell.subTitleLabel.textColor = .black
      }
      return cell
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 8
  }
  
  override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 8
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let videoURL = BaseViewData(dictionary: HomeViewData[indexPath.row])?.action else {
      return
    }
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return viewForHeaderAndFooter()
  }
  
  override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return viewForHeaderAndFooter()
  }
  
  private func viewForHeaderAndFooter() -> UIView {
    let viewH = UIView()
    viewH.backgroundColor = .white
    return viewH
  }
  

}
