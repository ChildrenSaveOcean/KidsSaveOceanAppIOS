//
//  KSOBaseViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 6/2/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

class KSOBaseViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var subViewsData:KSODataArray!
    var subViewHeight:CGFloat = 0
    
    var stackView:UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var subViews = [KSOBaseSubView]()
        
        for subViewFields in subViewsData {
            subViews.append(createSubView(subViewFields))
        }
        
        stackView = UIStackView(arrangedSubviews: subViews)
        scrollView.addSubview(stackView)
        
        stackView.applyToScrollView(scrollView)
        scrollView.contentSize = stackView.frame.size
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createSubView(_ subViewF:KSODataDictionary) ->(KSOBaseSubView) {
        
        let subViewData = StandartViewData(dictionary: subViewF)
        
        let subViewFrame = CGRect(x:0, y:0, width:343, height:subViewHeight) //// TODO: aware 343 !!!
        let subView = KSOBaseSubView(frame:subViewFrame)
        
        subView.image?.setImage(subViewData?.image, for: .normal)
        
        subView.titleLabel?.text = subViewData?.title
        subView.subTitleLabel.text = subViewData?.subTitle
        subView.descriptionLabel?.text = subViewData?.decription
        
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        return subView
        
    }
}
