//
//  KSOStartPageViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 5/18/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit

final class KSOStartPageViewController: UIPageViewController, Instantiatable {

    let onBoardingStoryboardName = "Onboarding"
    
    fileprivate lazy var pages: [UIViewController] = {
        return [
            self.getViewController(withIdentifier: "onBoardingPage1"),
            self.getViewController(withIdentifier: "onBoardingPage2"),
            self.getViewController(withIdentifier: "onBoardingPage3")
            ]
    }()

    private var pageControl = UIPageControl()

    private func getViewController(withIdentifier identifier: String) -> UIViewController {
        return UIStoryboard(name: onBoardingStoryboardName, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self as UIPageViewControllerDataSource
        self.delegate   = self as UIPageViewControllerDelegate

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
        pageControl = UIPageControl(frame: CGRect(x: UIScreen.main.bounds.maxX - 130,
                                                  y: UIScreen.main.bounds.maxY - 50,
                                                  width: 200,
                                                  height: 50))
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.darkGray
        self.view.addSubview(pageControl)

    }

    private func refuseBounces(_ scrollView: UIScrollView) {
        if pageControl.currentPage == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
        } else if pageControl.currentPage == pages.count - 1 && scrollView.contentOffset.x > scrollView.bounds.size.width {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
        }
    }
}

// MARK: UIPageViewControllerDataSource
extension KSOStartPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0          else { return nil }
        guard pages.count > previousIndex else { return nil }
        return pages[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else { return nil }
        guard pages.count > nextIndex else { return nil }
        return pages[nextIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = pages.firstIndex(of: pageContentViewController)!
    }
}

extension KSOStartPageViewController: UIPageViewControllerDelegate { }

extension KSOStartPageViewController: UIScrollViewDelegate {
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    if pageControl.currentPage == 0 && scrollView.contentOffset.x <= scrollView.bounds.size.width {
      targetContentOffset.pointee = CGPoint(x: scrollView.bounds.size.width, y: 0)
    } else if pageControl.currentPage == pages.count - 1 && scrollView.contentOffset.x >= scrollView.bounds.size.width {
      targetContentOffset.pointee = CGPoint(x: scrollView.bounds.size.width, y: 0)
    }
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    refuseBounces(scrollView)
  }

  func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
    refuseBounces(scrollView)
  }
}
