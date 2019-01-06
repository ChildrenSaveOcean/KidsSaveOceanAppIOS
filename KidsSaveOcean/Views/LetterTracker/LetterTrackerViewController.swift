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
    @IBOutlet weak var pickerView: UIPickerView!
    
    private lazy var viewModel = LetterTrackerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchCountries()
        
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
        
        attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: fontColor, range: range)
        
        titleLalel.attributedText = attributedString
        navigationItem.titleView = titleLalel
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupSubmitButton() {
        submitButton.layer.cornerRadius = 5
    }
}

// MARK: - UIPickerViewDataSource
extension LetterTrackerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.allCountries?.count ?? 0
    }
}

// MARK: - UIPickerViewDelegate
extension LetterTrackerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = viewModel.allCountries?[row].name
        label.textAlignment = .center
        
        return label
    }
}
