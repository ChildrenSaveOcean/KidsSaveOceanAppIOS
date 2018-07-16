//
//  KSOUserTypeViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 5/25/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

final class KSOUserTypeViewController: KSOBaseViewController  {

    override func viewDidLoad() {
        subViewsData = KSOUserTypeViewData
        super.viewDidLoad()
    }
    
    // TODO:
    // 1) do loading video in background thread
    // 2) move all about webView to its own class (or extention) ?
    // 3) show this VC only once (like and Start Page View Controller)
    // 4) Check the internet connection and implement the logic what to do without internet.
    
    
    override func touchView(_ actionString: String) {
        
        
        let webView = UIWebView(frame: view.bounds)
        
        view.addSubview(webView)
        view.bringSubview(toFront: webView)
        
        guard
            let youtubeURL = URL(string: "https://www.youtube.com/embed/\(actionString)")
            else { return }
        
        webView.loadRequest( URLRequest(url: youtubeURL) )
        
        let buttonsWidth:CGFloat = 100
        let buttonsHeight:CGFloat = 50
        let shiftY = view.bounds.height - 90
        let shiftX = (view.bounds.width - 2*buttonsWidth)/3
        
        let goButton = UIButton(frame: CGRect(x: shiftX, y: shiftY, width:buttonsWidth, height:buttonsHeight))
        goButton.backgroundColor = UIColor.gray
        goButton.setTitle("Start", for: .normal)
        goButton.titleLabel?.textColor = UIColor.black
        goButton.roundCorners()
        
        webView.addSubview(goButton)
        webView.bringSubview(toFront: goButton)
        
        goButton.addTargetClosure { (sender) in
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let tabViewController = storyBoard.instantiateViewController(withIdentifier: "tabViewController")
            self.present(tabViewController, animated: true, completion: nil)
            //self.performSegue(withIdentifier: "gotoHomeScreen", sender: nil)
        }
        
        let backButton = UIButton(frame: CGRect(x: view.bounds.width - buttonsWidth - shiftX, y: shiftY, width:buttonsWidth, height:buttonsHeight))
        backButton.backgroundColor = UIColor.gray
        backButton.setTitle("Back", for: .normal)
        backButton.titleLabel?.textColor = UIColor.black
        backButton.roundCorners()
        
        webView.addSubview(backButton)
        webView.bringSubview(toFront: backButton)
        
        backButton.addTargetClosure { (sender) in
            webView.stopLoading()
            webView.removeFromSuperview()
        }
        
    }
}
