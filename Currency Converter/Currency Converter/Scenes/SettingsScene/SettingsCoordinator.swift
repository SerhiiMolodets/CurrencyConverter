//
//  SettingsCoordinator.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 04.08.2023.
//

import UIKit

class SettingsCoordinator: Coordinator {
    
    // MARK: - Properties
    let rootController: UINavigationController
    
    // MARK: - Coordinator
    init(_ rootController: UINavigationController) {
        self.rootController = rootController
    }

    override func start() {
        openSettingsController()
        addChildCoordinator(self)
    }

    override func finish() {
        removeChildCoordinator(self)
        rootController.removeFromParent()
    }
    
    // MARK: - Navigation funcs
    private func openSettingsController() {
        let viewController = SettingsViewController.instantiate(coordinator: self)
        rootController.tabBarItem = UITabBarItem(title: nil, image: TabBarItems.settings.image, tag: 3)
        rootController.pushViewController(viewController, animated: true)
    }

}