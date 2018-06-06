//
//  KSONewsViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 5/31/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

fileprivate struct NewsViewDimentions {
    static let kNewsViewHeight:CGFloat = 202
}

final class KSONewsViewController: KSOBaseViewController { //, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        subViewsData = KSONewsViewData
        subViewHeight = CGFloat(NewsViewDimentions.kNewsViewHeight)
        super.viewDidLoad()
        
        //MARK: - add table with news
        let newsTableViewController = KSOBaseTableViewController(style: .grouped)
        newsTableViewController.tableView.layoutIfNeeded()

        newsTableViewController.tableView.isScrollEnabled = false
        newsTableViewController.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(newsTableViewController.tableView)
        scrollView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: stackView.subviews[0].subviews[0].bounds.width),
            containerView.heightAnchor.constraint(equalToConstant: newsTableViewController.tableView.contentSize.height),
            containerView.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: stackView.frame.height)
        ])
        containerView.layoutIfNeeded()
        
        addChildViewController(newsTableViewController)
        containerView.addSubview(newsTableViewController.tableView)
        
        newsTableViewController.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsTableViewController.tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            newsTableViewController.tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant:0),
            newsTableViewController.tableView.topAnchor.constraint(equalTo: containerView.topAnchor, constant:0),
            newsTableViewController.tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant:0)
            ])
        
        newsTableViewController.didMove(toParentViewController: self)
        
        //temporary. TODO: avoid hardcode values
        scrollView.contentSize =  CGSize(width: scrollView.contentSize.width, height: stackView.frame.height + containerView.frame.height + 10)
    }
    
    override func createSubView(_ subViewF: KSODataDictionary) -> (KSOBaseSubView) {
        let subView = super.createSubView(subViewF)
        subView.subTitleLabel.textColor = .white
        return subView
    }
    
}
