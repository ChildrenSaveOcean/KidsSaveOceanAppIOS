//
//  KSOResourcesTableViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 6/5/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

class KSOResourcesTableViewController: KSOBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.contentInset = UIEdgeInsets(top:kStandardViewGap, left:0, bottom:0, right:0)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return KSOResourcesStudentsTableViewData.count
        default:
            return KSOResourcesTeacherTableViewData.count
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = super.tableView(tableView, viewForHeaderInSection: section) as! KSOBaseTableHeaderView
        switch section {
        case 0:
            view.headerTitle.text = "For Students"
        default:
            view.headerTitle.text = "For Teachers"
        }
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            tableViewData = KSOResourcesStudentsTableViewData
        default:
            tableViewData = KSOResourcesTeacherTableViewData
        }
        
        let cell = getCellFor(indexPath)
        
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 1):
            self.showCountryContactView()
        default:
            break
        }
    }
    
    func showCountryContactView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let countryContactsViewController = storyboard.instantiateViewController(withIdentifier: "CountryContactsViewController")
        let navigationController = UINavigationController.init(rootViewController: countryContactsViewController)
        
        self.present(navigationController, animated: true, completion: nil)
    }
}

