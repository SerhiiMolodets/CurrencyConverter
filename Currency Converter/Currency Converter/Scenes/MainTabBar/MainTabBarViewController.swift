//
//  MainTabBarViewController.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 04.08.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    // MARK: - Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    // MARK: - Flow funcs
    private func setupTabBar() {
        self.viewControllers = [UIViewController()]
        self.viewControllers = []
        tabBar.backgroundColor = .white
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.tabBarUnselected.cgColor
        tabBar.tintColor = .tabBarSelected
        tabBar.unselectedItemTintColor = .tabBarUnselected
    }
    
}

enum TabBarItems: String {
    case currencyList, wallet, bids, settings
    var image: UIImage? {
        switch self {
        case .currencyList:
            return UIImage(named: "currency-dollar")
        case .wallet:
            return UIImage(named: "wallet")
        case .bids:
            return UIImage(named: "credit-card-alt")
        case .settings:
            return UIImage(named: "settings")
        }
    }
}
