//
//  HomeTableViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 9/25/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit
import Firebase

final class HomeTableViewController: UITableViewController {

  private let homeCellIdenteficator = "homeViewCellIdentificator"
  private let scoreCellIdenteficator = "scoreViewCellIdentificator"

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.isHidden = true
    tableView.isScrollEnabled = true
    tableView.bounces = false
    tableView.isUserInteractionEnabled = true
    tableView.separatorStyle = .none
    tableView.showsVerticalScrollIndicator = false
    tableView.estimatedRowHeight = 172
    tableView.rowHeight = UITableView.automaticDimension
    tableView.dataSource = self
    tableView.delegate   = self

    tabBarController?.delegate = self

    self.tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: homeCellIdenteficator)
    self.tableView.register(UINib(nibName: "HomeScoreTableViewCell", bundle: nil), forCellReuseIdentifier: scoreCellIdenteficator)

    NotificationCenter.default.addObserver(self, selector: #selector(reloadScores), name: .countriesHasBeenLoaded, object: nil)
  }

  override func viewWillDisappear(_ animated: Bool) {
     super.viewWillDisappear(animated)
     navigationController?.navigationBar.isHidden = false
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = true
    navigationController?.setStatusBarColor(UIColor.backgroundGray)
  }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let notificationItem = UserDefaultsHelper.forceShowingNotificationItem {
            NotificationController.shared.openTargetViewController(for: notificationItem)
        }

        clearNotifications()
    }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return HomeViewData.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let staticData = BaseTableViewData(with: HomeViewData[indexPath.row])
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: homeCellIdenteficator, for: indexPath) as? HomeTableViewCell else { fatalError("Wrong cell type. There is expected HomeScoreTableViewCell") }
    
    cell.configure(with: staticData as AnyObject?)
    
    if [2, 4].contains(indexPath.row) {
        cell.setDarkLetters()
    }
    
    return cell
  }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if let hCell = (cell as? HomeTableViewCell) {
            hCell.titleLabel.sizeToFit()
            hCell.subTitleLabel.sizeToFit()
        }

        guard let cell = (cell as? NotificationBadgeProtocol)  else { return }

        switch indexPath.row {
        case 0:
            cell.checkNotificationStatusForTarget(.newsAndMedia)
            if cell.isNotificationActualForTarget(.newsAndMedia) != true {
                cell.checkNotificationStatusForTarget(.policyChange)
            }

        case 3:
            cell.checkNotificationStatusForTarget(.actionAlert)

        case 4:
            cell.checkNotificationStatusForTarget(.newHighScore)

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
        let taskViewController = WriteToWhereViewController.instantiate()
        taskViewController.title = ""
        navigationController?.pushViewController(taskViewController, animated: true)
        
    case 2:
        let taskViewController = CreateNewEnvironmentPolicyViewController.instantiate()
        taskViewController.title = ""
        navigationController?.pushViewController(taskViewController, animated: true)

    case 3:
        tabBarController?.switchToDashboardScreen()

    case 4:
        tabBarController?.switchToMapScreen()

    case 5:
        tabBarController?.showLink("https://www.kidssaveocean.com/sharelikeaboss", clear: nil)
        
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
    viewH.backgroundColor = .backgroundGray
    return viewH
  }

    @objc private func reloadScores() {
        tableView.reloadRows(at: [IndexPath(row: 4, section: 0)], with: UITableView.RowAnimation.none)
    }
}

extension HomeTableViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if tabBarController.selectedViewController == viewController,
            let webViewController = tabBarController.getSelectedTabMainViewController() as? WebIntegrationViewController {
            webViewController.refreshView()
        }
        return true
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabBarController.refreshSelectedTab()
        tabBarController.updateNotificationStatusOfSelectedViewController()
    }
}

extension HomeTableViewController: NotificationProtocol {
    var notificationTargets: [NotificationTarget] {
        return [.unknown, .signatureCampaign]
    }
    
    @objc func updateViews() {
        clearNotifications()
        tableView.reloadData()
    }
}
