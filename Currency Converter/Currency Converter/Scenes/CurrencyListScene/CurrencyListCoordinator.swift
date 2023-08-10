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
    var viewModel: CurrencyListViewModel
    
    // MARK: - Coordinator
    init(_ rootController: UINavigationController, viewModel: CurrencyListViewModel) {
        self.rootController = rootController
        self.viewModel = viewModel
    }
    override func start() {
        openCurrencyListController()
        addChildCoordinator(self)
        guard let networkManager = Container.network.resolve(CurrencyNetworkProtocol.self) else { return }
        viewModel.networkManager = networkManager
    }
    override func finish() {
        removeChildCoordinator(self)
        rootController.removeFromParent()
    }
    
    // MARK: - Navigation funcs
    private func openCurrencyListController() {
        let viewController = UIHostingController(rootView: CurrencyListView().environmentObject(viewModel))
        rootController.tabBarItem = UITabBarItem(title: nil, image: TabBarItems.currencyList.image, tag: 0)
        rootController.pushViewController(viewController, animated: true)
    }

}
