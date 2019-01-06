//
//  UserTypeTableViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 9/24/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

class UserTypeTableViewController: UITableViewController {
  let activityIndicator = UIActivityIndicatorView(style:.gray)
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
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdenteficator, for: indexPath) as! UserTypeTableViewCell

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
    guard Reachability.isConnectedToNetwork() == true else {
      self.showErrorMessage("No Internet Connection.\nYou can go ahead without introducing video or try again", actionString: videoURL)
      return
    }
    self.showVideo(videoURL)
  }
  
  private func showVideo(_ videoAddressString:String) {
    webView.frame = view.bounds
    webView.delegate = self as UIWebViewDelegate
    
    view.addSubview(webView)
    view.bringSubviewToFront(webView)
    
    guard
      let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoAddressString)")
      else {
        self.showErrorMessage("Something goes wrong with video you've choosen.\nYou can go ahead without introducing video or try again", actionString: videoAddressString)
        return
    }
    
    webView.loadRequest( URLRequest(url: youtubeURL) )
  }
  
  private func videoHasBeenLoaded() {
    activityIndicator.stopAnimating()
    activityIndicator.removeFromSuperview()
    showActionButtons()
  }
  
  private func showActionButtons() {
    let buttonsWidth:CGFloat = 100
    let buttonsHeight:CGFloat = 50
    let shiftY = self.view.bounds.height - 90
    let shiftX = (self.view.bounds.width - 2*buttonsWidth)/3
    
    let goButton = self.createButtonWithTitle("GO AHEAD")
    goButton.frame = CGRect(x: shiftX, y: shiftY, width:buttonsWidth, height:buttonsHeight)
    
    goButton.addTargetClosure { (sender) in
      Settings.saveOnBoardingHasBeenShown()
      self.gotoTabViewController()
    }
    webView.addSubview(goButton)
    webView.bringSubviewToFront(goButton)
    
    let backButton = self.createButtonWithTitle("BACK")
    backButton.frame = CGRect(x: self.view.bounds.width - buttonsWidth - shiftX, y: shiftY, width:buttonsWidth, height:buttonsHeight)
    
    backButton.addTargetClosure { (sender) in
      self.webView.stopLoading()
      self.webView.removeFromSuperview()
    }
    webView.addSubview(backButton)
    webView.bringSubviewToFront(backButton)
  }
  
  private func createButtonWithTitle(_ title:String) -> UIButton {
    let button = UIButton()
    button.backgroundColor = .gray
    button.setTitle(title, for: .normal)
    button.titleLabel?.textColor = .black
    button.roundCorners()
    return button
  }
  
  private func gotoTabViewController() {
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let tabViewController = storyBoard.instantiateViewController(withIdentifier: Settings.tabViewControllerId)
    self.present(tabViewController, animated: true, completion: nil)
  }
  
  private func showErrorMessage(_ message:String, actionString:String) {
    
    let warnMessage = UIAlertController(title: "Warning",
                                        message: message,
                                        preferredStyle: .alert)
    
    let tryAgainButton = UIAlertAction(title: "Cancel and Try again", style: .cancel) { (action:UIAlertAction) in
      //
    }
    
    let goAheadButton = UIAlertAction(title: "GO AHEAD", style: .default) { (action:UIAlertAction) in
      self.gotoTabViewController()
    }
    
    warnMessage.addAction(goAheadButton)
    warnMessage.addAction(tryAgainButton)
    
    self.present(warnMessage, animated: true, completion: nil)
  }
}

// MARK: UIWebViewDelegate
extension UserTypeTableViewController: UIWebViewDelegate {
  func webViewDidStartLoad(_ webView: UIWebView) {
    activityIndicator.frame = CGRect(x:view.bounds.width/2, y:view.bounds.height/2, width:30, height:30)
    view.addSubview(activityIndicator)
    view.bringSubviewToFront(activityIndicator)
    activityIndicator.startAnimating()
  }
  
  func webViewDidFinishLoad(_ webView: UIWebView) {
    videoHasBeenLoaded()
  }
  
  func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
    videoHasBeenLoaded()
  }
}
