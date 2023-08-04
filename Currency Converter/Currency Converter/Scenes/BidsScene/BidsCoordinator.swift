//
//  BidsCoordinator.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 04.08.2023.
//

import UIKit

class BidsCoordinator: Coordinator {
    
    // MARK: - Properties
    let rootController: UINavigationController
    
    // MARK: - Coordinator
    init(_ rootController: UINavigationController) {
        self.rootController = rootController
    }

    override func start() {
        openBidsController()
        addChildCoordinator(self)
    }
    
    override func finish() {
        removeChildCoordinator(self)
        rootController.removeFromParent()
    }
    
    // MARK: - Navigation funcs
    private func openBidsController() {
        let viewController = BidsViewController.instantiate(coordinator: self)
        rootController.tabBarItem = UITabBarItem(title: nil, image: TabBarItems.bids.image, tag: 2)
        rootController.pushViewController(viewController, animated: true)
    }

}
