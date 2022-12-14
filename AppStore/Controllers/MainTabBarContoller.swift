//
//  MainTabBarContoller.swift
//  AppStore
//
//  Created by Tilek Koszhanov on 10/17/22.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createNavController(viewController: TodayController(), title: "Today", imageName: "today"),
            createNavController(viewController: AppsPageController(), title: "Apps", imageName: "apps"),
            createNavController(viewController: SearchController(), title: "Search", imageName: "search")
        ]
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UINavigationController {
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        
        viewController.view.backgroundColor = .white
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(named: imageName)
        viewController.navigationItem.title = title
        
        return navController
    }
    
}
