//
//  CreateEventPageViewController.swift
//  smidig
//
//  Created by Jan-Kristian Evjen on 5/27/19.
//  Copyright © 2019 Tom Fevang. All rights reserved.
//

import UIKit

class CreateEventPageViewController: UIPageViewController, UIPageViewControllerDelegate {

    lazy var subViewControllers : [UIViewController] = {
        return [
            UIStoryboard(name: "Event", bundle: nil).instantiateViewController(withIdentifier: "createEventOne"),
            UIStoryboard(name: "Event", bundle: nil).instantiateViewController(withIdentifier: "createEventTwo"),
            UIStoryboard(name: "Event", bundle: nil).instantiateViewController(withIdentifier: "createEventThree"),
        ]
    }()
    
    var event: Event?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.delegate   = self
        
        self.setViewControllers([subViewControllers[0]], direction: .forward, animated: false, completion: nil)
    }

    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex:Int = subViewControllers.index(of: viewController) ?? 0
        if (currentIndex <= 0) {
            return nil
        }
        
        return subViewControllers[currentIndex-1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex:Int = subViewControllers.index(of: viewController) ?? 0
        if (currentIndex >= subViewControllers.count-1) {
            return nil
        }
        
        return subViewControllers[currentIndex+1]
    }

}
