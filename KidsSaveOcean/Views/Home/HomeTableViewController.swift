//
//  HomeTableViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 9/25/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit
import Firebase

final class HomeTableViewController: UITableViewController, NotificationProtocol {

  private let homeCellIdenteficator = "homeViewCellIdentificator"
  private let scoreCellIdenteficator = "scoreViewCellIdentificator"

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.isHidden = true
    navigationController?.navigationBar.isTranslucent = true
    tableView.backgroundColor = UIColor.backgroundGray
    tableView.isScrollEnabled = true
    tableView.bounces = false
    tableView.isUserInteractionEnabled = true
    tableView.separatorStyle = .none
    tableView.separatorColor = UIColor.backgroundGray
    tableView.showsVerticalScrollIndicator = false
    tableView.estimatedRowHeight = 172
    tableView.rowHeight = UITableView.automaticDimension
    tableView.dataSource = self
    tableView.delegate   = self

    tabBarController?.delegate = self

    self.tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: homeCellIdenteficator)
    self.tableView.register(UINib(nibName: "HomeScoreTableViewCell", bundle: nil), forCellReuseIdentifier: scoreCellIdenteficator)

    NotificationCenter.default.addObserver(self, selector: #selector(reloadScores), name: NSNotification.Name(Settings.CountriesHasBeenLoadedNotificationName), object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(reload), name:
    Notification.Name.NSExtensionHostDidBecomeActive, object: nil)
    
  }

  override func viewWillDisappear(_ animated: Bool) {
     super.viewWillDisappear(animated)
     navigationController?.navigationBar.isHidden = false
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = true
  }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        clearNotificationForTarget(.unknown)
//        reload()
    }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return HomeViewData.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let staticData = BaseTableViewData(dictionary: HomeViewData[indexPath.row])

    if indexPath.row == 4 {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: scoreCellIdenteficator, for: indexPath) as? HomeScoreTableViewCell else { fatalError("Wrong cell type. There is expected HomeScoreTableViewCell") }

        cell.configure(with: nil)
        return cell

    } else {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: homeCellIdenteficator, for: indexPath) as? HomeTableViewCell else { fatalError("Wrong cell type. There is expected HomeScoreTableViewCell") }
        
        cell.configure(with: staticData as AnyObject?)
        
        if indexPath.row == 2 {
            cell.setDarkLetters()
        }
        
      return  cell
    }
  }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cellNP = (cell as? NotificationBadgeProtocol)  else {
            return
        }
        switch indexPath.row {
        case 0:
            cellNP.checkNotificationStatusForTarget(.newsAndMedia)
            cellNP.checkNotificationStatusForTarget(.policyChange)
        case 3:
            cellNP.checkNotificationStatusForTarget(.actionAlert)
        case 4:
            cellNP.checkNotificationStatusForTarget(.newHighScore)
        default:
            break
        }
    }

  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 8
  }

  override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 8
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0:
        tabBarController?.switchToNewsAndMediaScreen()

    case 1:
      navigationController?.pushViewController(CountryContactsViewController.instantiate(), animated: true)
        
    case 2:
        tabBarController?.switchToMapScreen()

    case 3:
        tabBarController?.switchToDashboardScreen()

    case 4:
        tabBarController?.switchToHighScoreScreen()

    default:
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

    @objc private func reloadScores() {
        tableView.reloadRows(at: [IndexPath(row: 4, section: 0)], with: UITableView.RowAnimation.none)
    }
    
    @objc func reload() {
        tableView.reloadData()
    }
}

extension HomeTableViewController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabBarController.refreshSelectedTab()
        if tabBarController.selectedViewController == self.navigationController {
            reload()
        }
    }
    
    //func tabBarCon
    
}
