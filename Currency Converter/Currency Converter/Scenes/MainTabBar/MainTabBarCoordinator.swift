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
        guard var viewModel = Container.wallet.resolve(WalletViewModelProtocol.self) else { return }
        guard let realmManager = Container.realm.resolve(RealmManagerWalletProtocol.self) else { return }
        viewModel.realmManager = realmManager
        let coordinator = WalletCoordinator(UINavigationController(), viewModel)
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
        guard let viewModel = Container.bids.resolve(BidsViewModelProtocol.self) else { return }
        let coordinator = BidsCoordinator(UINavigationController(), viewModel)
        rootTabBarController.viewControllers?.append(coordinator.rootController)
        addChildCoordinator(coordinator)
        coordinator.start()
    }
    
    private func addSettingsPage() {
        guard let viewModel = Container.settings.resolve(SettingsViewModelProtocol.self) else { return }
        viewModel.loadSelectedCurrency()
        let coordinator = SettingsCoordinator(UINavigationController(), viewModel)
        rootTabBarController.viewControllers?.append(coordinator.rootController)
        addChildCoordinator(coordinator)
        coordinator.start()
    }
}
