//
//  KSOStartPageViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 5/18/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

final class KSOStartPageViewController: UIPageViewController {

    // TODO: Move logic from Storyboard to here

    fileprivate lazy var pages: [UIViewController] = {
        return [
            self.getViewController(withIdentifier: "onBoardingPage1"),
            self.getViewController(withIdentifier: "onBoardingPage2"),
            self.getViewController(withIdentifier: "onBoardingPage3")
            ]
    }()

    fileprivate var pageControl = UIPageControl()

    fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self as UIPageViewControllerDataSource
        self.delegate   = self as UIPageViewControllerDelegate

        //test if the user already click start
        let defaults = UserDefaults.standard
        if let alreadyStart = defaults.object(forKey: "AlreadyStart") {
            if alreadyStart as! Bool {
                let vc: UIViewController = self.getViewController(withIdentifier: "tabbarStartScreen")
                setViewControllers([vc], direction: .forward, animated: true, completion: nil)

            } else {
                config()
            }
        } else {
            config()
        }

    }

    func config() {

        if let firstVC = pages.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }

        for subview in self.view.subviews {
            if let scrollView = subview as? UIScrollView {
                scrollView.delegate = self as UIScrollViewDelegate
                break
            }
        }

        configurePageControl()
    }

    func configurePageControl() {

        pageControl = UIPageControl(frame: CGRect(x: UIScreen.main.bounds.maxX - 180,
                                                  y: UIScreen.main.bounds.maxY - 100,
                                                  width: 200,
                                                  height: 50))
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.darkGray
        self.view.addSubview(pageControl)

    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if (pageControl.currentPage == 0 && scrollView.contentOffset.x <= scrollView.bounds.size.width) {
            targetContentOffset.pointee = CGPoint(x: scrollView.bounds.size.width, y: 0)
        } else if (pageControl.currentPage == pages.count - 1 && scrollView.contentOffset.x >= scrollView.bounds.size.width) {
            targetContentOffset.pointee = CGPoint(x: scrollView.bounds.size.width, y: 0)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        refuseBounces(scrollView)
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        refuseBounces(scrollView)
    }

    fileprivate func refuseBounces(_ scrollView: UIScrollView) {
        if (pageControl.currentPage == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width) {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
        } else if (pageControl.currentPage == pages.count - 1 && scrollView.contentOffset.x > scrollView.bounds.size.width) {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: UIPageViewControllerDataSource

extension KSOStartPageViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0          else { return nil }
        guard pages.count > previousIndex else { return nil }
        return pages[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else { return nil }
        guard pages.count > nextIndex else { return nil }
        return pages[nextIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = pages.index(of: pageContentViewController)!
    }
}

extension KSOStartPageViewController: UIPageViewControllerDelegate { }

extension KSOStartPageViewController: UIScrollViewDelegate { }
