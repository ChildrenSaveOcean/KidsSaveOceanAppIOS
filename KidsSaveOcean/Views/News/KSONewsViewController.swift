//
//  KSONewsViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 5/31/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

final class KSONewsViewController: KSOBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - add table with news
    private let newsTableViewController =  { () -> KSOBaseTableViewController in
        let tableViewController = KSOBaseTableViewController(style: .grouped)
        tableViewController.tableViewData = KSONewsTableViewData
        tableViewController.tableView.isScrollEnabled = false
        return tableViewController
    } ()
    
    // MARK: add container View for placing tableView
    private let containerView = { () -> UIView in
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    override func viewDidLoad() {
        
        subViewsData = KSONewsViewData // set data
        super.viewDidLoad()
        
        newsTableViewController.tableView.layoutIfNeeded()
        newsTableViewController.tableView.delegate = self as UITableViewDelegate
        newsTableViewController.tableView.dataSource = self as UITableViewDataSource
        
        containerView.addSubview(newsTableViewController.tableView)
        scrollView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: stackView.bounds.width),
            containerView.heightAnchor.constraint(equalToConstant: newsTableViewController.tableView.contentSize.height),
            containerView.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: stackView.frame.height + 2 * StandardViewGap)
            ])
        
        addChildViewController(newsTableViewController)
        containerView.addSubview(newsTableViewController.tableView)
        
        newsTableViewController.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsTableViewController.tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            newsTableViewController.tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            newsTableViewController.tableView.topAnchor.constraint(equalTo: containerView.topAnchor),
            newsTableViewController.tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
        containerView.layoutIfNeeded()
        newsTableViewController.didMove(toParentViewController: self)
        
        scrollView.contentSize =  CGSize(width: scrollView.contentSize.width,
                                         height: stackView.frame.height + containerView.frame.height + 2 * StandardViewGap)
    }
    
    
    override func createSubView(_ subViewF: KSODataDictionary, orientation:ViewOrientation) -> (KSOBaseSubView) {
        
        let subView = super.createSubView(subViewF, orientation: .horisontal)
        subView.subTitleLabel.textColor = .white
        /// TODO: probable we have to change the constraints of labels here
        return subView
    }
    
    // MARK: UITableViewDelegate methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("selected row  #\(indexPath.row) in section #\(indexPath.section)")
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = newsTableViewController.tableView(tableView, viewForHeaderInSection: section) as! KSOBaseTableHeaderView
        view.headerTitle.text = "News and Updates"
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame:CGRect(x:0, y:0, width: tableView.frame.size.width, height:1)) // this is removing last separator line
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return StandardTableHeaderHeight
    }
    
    // MARK: DataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return KSONewsTableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableViewController.createCell(at: indexPath)
        return cell
    }
    
}
