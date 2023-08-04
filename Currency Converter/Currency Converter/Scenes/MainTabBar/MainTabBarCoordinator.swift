//
//  MainTabBarCoordinator.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 04.08.2023.
//

import UIKit

class MainTabBarCoordinator: Coordinator {
    
    let rootTabBarController: UITabBarController
    
    init(_ rootTabBarController: UITabBarController) {
        self.rootTabBarController = rootTabBarController
    }

    override func start() {
        addWalletPage()
    }
    
    private func addWalletPage() {
        let coordinator = WalletCoordinator(UINavigationController())
        rootTabBarController.viewControllers?.append(coordinator.rootController)
        addChildCoordinator(coordinator)
        coordinator.start()
    }
    
}
