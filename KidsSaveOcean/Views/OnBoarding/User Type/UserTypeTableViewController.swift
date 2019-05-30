//
//  UserTypeTableViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 9/24/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

class UserTypeTableViewController: UITableViewController {
  let activityIndicator = UIActivityIndicatorView(style: .gray)
  let webView = UIWebView()

  private let cellIdenteficator = "userIdCellIdentificator"
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.backgroundColor = UIColor.backgroundGray
    tableView.isScrollEnabled = true
    tableView.bounces = false
    tableView.isUserInteractionEnabled = true
    tableView.separatorStyle = .none
    tableView.separatorColor = UIColor.backgroundGray
    tableView.showsVerticalScrollIndicator = false
    tableView.rowHeight = UITableView.automaticDimension
    tableView.dataSource = self
    tableView.delegate   = self
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return UserTypeViewData.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdenteficator, for: indexPath) as? UserTypeTableViewCell else { fatalError("Wrong cell type. There is expected UserTypeTableViewCell")}

    let staticData = BaseViewData(dictionary: UserTypeViewData[indexPath.row])
    cell.coverImage.image =  staticData?.image
    cell.titleLabel.text = staticData?.title
    cell.subTitleLabel.text = staticData?.subTitle
    cell.descriptionLabel.text = staticData?.decription
    return cell
  }

  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return CGFloat.leastNormalMagnitude
  }

  override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return CGFloat.leastNormalMagnitude
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let videoURL = BaseViewData(dictionary: UserTypeViewData[indexPath.row])?.action else {
      return
    }
    self.showVideo(videoURL, userType: UserType(rawValue: indexPath.row)!)
  }

    private func showVideo(_ videoAddressString: String, userType: UserType) {
    let videoViewController = UserTypeVideoViewController()
    videoViewController.urlString = videoAddressString
    videoViewController.delegate = self
    videoViewController.userType = userType
    /*navigationController?.navigationBar.isHidden = false
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
    navigationController?.navigationBar.backgroundColor = .clear
    navigationController?.navigationBar.frame = CGRect(x:0, y:0, width:view.bounds.width, height: 40)*/
    navigationController?.pushViewController(videoViewController, animated: true)
  }

    internal func gotoTabViewController() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tabViewController = storyBoard.instantiateViewController(withIdentifier: Settings.tabViewControllerId)
        self.present(tabViewController, animated: true, completion: nil)
    }

   func showErrorMessage(_ message: String, actionString: String) {

    let warnMessage = UIAlertController(title: "Warning",
                                        message: message,
                                        preferredStyle: .alert)

    let tryAgainButton = UIAlertAction(title: "Cancel and Try again", style: .cancel) { (_:UIAlertAction) in
      //
    }

    let goAheadButton = UIAlertAction(title: "GO AHEAD", style: .default) { (_:UIAlertAction) in
      self.gotoTabViewController()
    }

    warnMessage.addAction(goAheadButton)
    warnMessage.addAction(tryAgainButton)

    self.present(warnMessage, animated: true, completion: nil)
  }
}

// MARK: UserTypeVideoDelegate
extension UserTypeTableViewController: UserTypeVideoDelegate {

}
