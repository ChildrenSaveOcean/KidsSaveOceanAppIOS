//
//  LetterTrackerViewController.swift
//  KidsSaveOcean
//
//  Created by Oleg Ivaniv on 12/5/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import Foundation
import SnapKit

final class LetterTrackerViewController: UIViewController {

    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateViewConstraints()
    }
    
    private func setupViewElements() {
        setupNavigationBar()
        setupSubmitButton()
    }
    
    private func setupNavigationBar() {
        let fontColor = UIColor.black
        let titleLalel = UILabel()
        
        let attributedString = NSMutableAttributedString(string: "Letter Tracker")
        
        let length = attributedString.length
        let range = NSMakeRange(0, length)
        let font =  UIFont(name: "SF-Pro-Text-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20)
        
        attributedString.addAttribute(NSAttributedStringKey.font, value: font, range: range)
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: fontColor, range: range)
        
        titleLalel.attributedText = attributedString
        navigationItem.titleView = titleLalel
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupSubmitButton() {
        submitButton.layer.cornerRadius = 5
    }
}
