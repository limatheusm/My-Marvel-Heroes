//
//  TabBarViewController.swift
//  MyMarvelHeroes
//
//  Created by Matheus Lima on 18/02/19.
//  Copyright © 2019 Matheus Lima. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var previousController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if previousController == viewController || previousController == nil {
            // the same tab was tapped a second time
            let nav = viewController as! UINavigationController
            
            // if in first level of navigation (table view) then and only then scroll to top
            if nav.viewControllers.count < 2 {
                guard let heroesVC = nav.topViewController as? HeroesViewController else { return true }
                heroesVC.scrollToTop()
            }
        }
        self.previousController = viewController;

        return true
    }
}
