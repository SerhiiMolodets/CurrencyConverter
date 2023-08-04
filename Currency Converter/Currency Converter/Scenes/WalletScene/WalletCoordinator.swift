//
//  WalletCoordinator.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 04.08.2023.
//

import UIKit

class WalletCoordinator: Coordinator {
    
    let rootController: UINavigationController
    
    init(_ rootController: UINavigationController) {
        self.rootController = rootController
    }
    
    override func start() {
        openWalletController()
        addChildCoordinator(self)
    }
    
    override func finish() {
        removeChildCoordinator(self)
        rootController.removeFromParent()
    }
    
    private func openWalletController() {
        let viewController = WalletViewController.instantiate(coordinator: self)
        rootController.tabBarItem = UITabBarItem(title: nil, image: TabBarItems.wallet.image, tag: 1)
        rootController.pushViewController(viewController, animated: true)
    }

}
