//
//  TabBarViewController.swift
//  whenMyBusGo
//
//  Created by Oscar on 11/11/23.
//

import UIKit

class TabBarViewController: UITabBarController {
    private lazy var favoriteBusViewController: UIViewController = {
        let viewController = FavoriteBusViewController()
        let tabBarItem = UITabBarItem(title: "즐겨찾기", image: UIImage(systemName: "heart.fill"), tag: 0)
        
        viewController.tabBarItem = tabBarItem
        
        return viewController
    }()
    
    private lazy var busTimetableViewController: UIViewController = {
        let viewController = BusTimetableViewController()
        let tabBarItem = UITabBarItem(title: "버스 목록", image: UIImage(systemName: "bus"), tag: 0)
        
        viewController.tabBarItem = tabBarItem
        
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [favoriteBusViewController, busTimetableViewController]
        setTabBar()
    }
}

extension TabBarViewController {
    func setTabBar() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = UIColor(named: "mainColor")
        tabBar.layer.cornerRadius = 20
        tabBar.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        tabBar.layer.borderWidth = 1
    }
}

