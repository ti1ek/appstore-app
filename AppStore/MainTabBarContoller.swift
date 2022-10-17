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
        
        let redViewController = UIViewController()
        redViewController.view.backgroundColor = .white
        redViewController.tabBarItem.title = "Today"
        redViewController.tabBarItem.image = #imageLiteral(resourceName: "today_icon")
        redViewController.navigationItem.title = "Today"
        
        let redNavController = UINavigationController(rootViewController: redViewController)
        redNavController.navigationBar.prefersLargeTitles = true


        
        let blueViewController = UIViewController()
        blueViewController.view.backgroundColor = .white
        blueViewController.tabBarItem.title = "Apps"
        blueViewController.tabBarItem.image = #imageLiteral(resourceName: "apps")
        blueViewController.navigationItem.title = "Apps"
       
        let blueNavController = UINavigationController(rootViewController: blueViewController)
        blueNavController.navigationBar.prefersLargeTitles = true

       
         
        let greenViewController = UIViewController()
        greenViewController.view.backgroundColor = .white
        greenViewController.tabBarItem.title = "Search"
        greenViewController.tabBarItem.image = #imageLiteral(resourceName: "search")
        greenViewController.navigationItem.title = "Search"
        
        let greenNavController = UINavigationController(rootViewController: greenViewController)
        greenNavController.navigationBar.prefersLargeTitles = true
        

        
        viewControllers = [
            redNavController,
            blueNavController,
            greenNavController
        ]
        
    }
    
}
