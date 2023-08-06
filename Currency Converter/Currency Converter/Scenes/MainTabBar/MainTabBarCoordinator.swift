//
//  MainTabBarCoordinator.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 04.08.2023.
//

import UIKit
import Swinject

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
        guard let viewModel = Container.settings.resolve(SettingsViewModelProtocol.self) else { return }
        let coordinator = SettingsCoordinator(UINavigationController(), viewModel)
        rootTabBarController.viewControllers?.append(coordinator.rootController)
        addChildCoordinator(coordinator)
        coordinator.start()
    }
}
