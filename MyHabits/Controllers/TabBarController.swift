//
//  TabBarController.swift
//  MyHabits
//
//  Created by mitr on 04.04.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = UIColor(named: "AppGray")
        createTabBarControllers()
    }
    
    
    
    func createTabBarControllers() {
        viewControllers = [
            createNavController(for: HabitsViewController(),
                                   title: "Привычки",
                                   image: UIImage(systemName: "rectangle.grid.1x2.fill")!),
            
            createNavController(for: InfoViewController(),
                                   title: "Информация",
                                   image: UIImage(systemName: "info.circle.fill")!)
        ]
    }
    
    func createNavController(for rootViewController: UIViewController,
                             title: String,
                             image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
