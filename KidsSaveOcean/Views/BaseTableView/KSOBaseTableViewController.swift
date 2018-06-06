//
//  KSOBaseTableViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 6/4/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

fileprivate let kCellIdentefire = "baseTableViewCellIdentefier"

class KSOBaseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = UIColor.yellow //UIColor.init(red: 245, green: 245, blue: 245, alpha: 245)
        //tableView.contentInset = UIEdgeInsets.zero
        tableView.isScrollEnabled = true
        tableView.alwaysBounceVertical = false
        tableView.isUserInteractionEnabled = true
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        tableView.insetsContentViewsToSafeArea = true
        //tableView.contentInsetAdjustmentBehavior = .never
        
        tableView.dataSource = self
        tableView.delegate   = self

        tableView.register(KSOBaseTableViewCell.self, forCellReuseIdentifier: kCellIdentefire)
        //self.tableView.register(UINib(nibName: "KSOBaseTableViewCell", bundle: nil),   forCellReuseIdentifier: kCellIdentefire)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentefire, for: indexPath)  as! KSOBaseTableViewCell
        
        ///this is ugly temporary part, it will be a header view
        if indexPath.row == 0 {
            let title = UILabel(frame: cell.bounds)
            title.text = "News and Updates"
            title.font = UIFont(name: "Helvetica Neue", size: 32)
            title.adjustsFontForContentSizeCategory = true
            cell.tableViewIcon.removeFromSuperview()
            cell.tableViewTitle.removeFromSuperview()
            cell.tableViewSubTitle.removeFromSuperview()
            cell.addSubview(title)
            return cell
        }
        
        cell.accessoryType = .disclosureIndicator
        cell.layoutIfNeeded()
        cell.makeRoundIcon()
    
        return cell
    }
    
    
    // MARK: - make section corners rounded
   override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let rowsCount = tableView.numberOfRows(inSection: indexPath.section)
        
        let cornerRadius:CGFloat = 10 //// temporary, TODO: avoid of hardcode numbers
        
        if indexPath.row == 0 {
            
            cell.clipsToBounds = true
            cell.layer.cornerRadius = cornerRadius
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            
        } else if indexPath.row == rowsCount-1 {
            
            cell.clipsToBounds = true
            cell.layer.cornerRadius = cornerRadius
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude //0.000001
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude //0.000001
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}
