//
//  CurrencyListCoordinator.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 04.08.2023.
//

import UIKit
import SwiftUI
import Swinject

class CurrencyListCoordinator: Coordinator {
    
    // MARK: - Properties
    let rootController: UINavigationController
    
    // MARK: - Coordinator
    init(_ rootController: UINavigationController) {
        self.rootController = rootController
    }

    override func start() {
        openCurrencyListController()
        addChildCoordinator(self)
    }
    
    override func finish() {
        removeChildCoordinator(self)
        rootController.removeFromParent()
    }
    
    // MARK: - Navigation funcs
    private func openCurrencyListController() {
        guard let viewModel = Container.currencyList.resolve(CurrencyListViewModel.self) else { return }
        let viewController = UIHostingController(rootView: CurrencyListView().environmentObject(viewModel))
        rootController.tabBarItem = UITabBarItem(title: nil, image: TabBarItems.currencyList.image, tag: 0)
        rootController.pushViewController(viewController, animated: true)
    }

}
