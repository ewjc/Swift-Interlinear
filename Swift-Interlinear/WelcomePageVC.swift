//
//  ViewController.swift
//  Swift-Interlinear
//
//  Created by Eric Wong on 11/17/18.
//  Copyright © 2018 Eric Wong. All rights reserved.
//

import UIKit

class WelcomePageVC: UIPageViewController {
    
    lazy var orderedViewControllers: [UIViewController] = {
        let vcOne = WelcomePageOne()
        let vcTwo = WelcomePageTwo()
        let vcThree = WelcomePageThree()

        return [vcOne, vcTwo, vcThree]
    }()
    
    let pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.dataSource = self
        
        if let firstVC = orderedViewControllers.first {
            setViewControllers([firstVC], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        }
        
        configurePageControl()
    }
    
    fileprivate func configurePageControl() {
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        
        view.addSubview(pageControl)
        pageControl.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 40, paddingBottom: -10, paddingRight: 40, width: 0, height: 0)
    }
    
}

extension WelcomePageVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.orderedViewControllers.index(of: viewController) else { return nil }
        
        if viewControllerIndex == 0 {
            // wrap to last page in array
            return nil
        } else {
            // go to previous page in array
            return self.orderedViewControllers[viewControllerIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.orderedViewControllers.index(of: viewController) else { return nil }
        
            if viewControllerIndex < self.orderedViewControllers.count - 1 {
                // go to next page in array
                return self.orderedViewControllers[viewControllerIndex + 1]
            } else {
                // wrap to first page in array
                return nil
            }

        
    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//
//        // set the pageControl.currentPage to the index of the current viewController in pages
//        if let viewControllers = pageViewController.viewControllers {
//            if let viewControllerIndex = self.orderedViewControllers.index(of: viewControllers[0]) {
//                self.pageControl.currentPage = viewControllerIndex
//            }
//        }
//    }
}

