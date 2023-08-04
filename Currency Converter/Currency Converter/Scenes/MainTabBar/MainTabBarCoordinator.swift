//
//  MainTabBarCoordinator.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 04.08.2023.
//

import UIKit

class MainTabBarCoordinator: Coordinator {
    
    // MARK: - Properties
    let rootTabBarController: UITabBarController
    
    // MARK: - Coordinator
    init(_ rootTabBarController: UITabBarController) {
        self.rootTabBarController = rootTabBarController
    }

    override func start() {
        addCurrencyListPage()
        addWalletPage()
        addBidsPage()
        addSettingsPage()
    }
    
    // MARK: - Navigation funcs
    private func addWalletPage() {
        let coordinator = WalletCoordinator(UINavigationController())
        rootTabBarController.viewControllers?.append(coordinator.rootController)
        addChildCoordinator(coordinator)
        coordinator.start()
    }
    
    private func addCurrencyListPage() {
        let coordinator = CurrencyListCoordinator(UINavigationController())
        rootTabBarController.viewControllers?.append(coordinator.rootController)
        addChildCoordinator(coordinator)
        coordinator.start()
    }
    
    private func addBidsPage() {
        let coordinator = BidsCoordinator(UINavigationController())
        rootTabBarController.viewControllers?.append(coordinator.rootController)
        addChildCoordinator(coordinator)
        coordinator.start()
    }
    
    private func addSettingsPage() {
        let coordinator = SettingsCoordinator(UINavigationController())
        rootTabBarController.viewControllers?.append(coordinator.rootController)
        addChildCoordinator(coordinator)
        coordinator.start()
    }
}
