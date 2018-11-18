//
//  ViewController.swift
//  Swift-Interlinear
//
//  Created by Eric Wong on 11/17/18.
//  Copyright © 2018 Eric Wong. All rights reserved.
//

import UIKit

class WelcomePageVC: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    lazy var orderedViewControllers: [UIViewController] = {
        let vcOne = WelcomePageOne()
        let vcTwo = WelcomePageTwo()

        return [vcOne]
    }()
    
    let pageControl = UIPageControl()
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.orderedViewControllers.index(of: viewController) {
            if viewControllerIndex == 0 {
                // wrap to last page in array
                return self.orderedViewControllers.last
            } else {
                // go to previous page in array
                return self.orderedViewControllers[viewControllerIndex - 1]
            }
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.orderedViewControllers.index(of: viewController) {
            if viewControllerIndex < self.orderedViewControllers.count - 1 {
                // go to next page in array
                return self.orderedViewControllers[viewControllerIndex + 1]
            } else {
                // wrap to first page in array
                return self.orderedViewControllers.first
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        // set the pageControl.currentPage to the index of the current viewController in pages
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.orderedViewControllers.index(of: viewControllers[0]) {
                self.pageControl.currentPage = viewControllerIndex
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.dataSource = self
        let initialPage = 0
    

        setViewControllers([orderedViewControllers[initialPage]], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPage = initialPage
        
        view.addSubview(pageControl)
        pageControl.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 40, paddingBottom: 10, paddingRight: 40, width: 0, height: 0)
    }

}

