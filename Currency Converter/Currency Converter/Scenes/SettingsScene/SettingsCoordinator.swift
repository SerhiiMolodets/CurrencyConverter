//
//  SettingsCoordinator.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 04.08.2023.
//

import UIKit
import SwiftUI
import RxSwift

class SettingsCoordinator: Coordinator {
    
    // MARK: - Properties
    let rootController: UINavigationController
    var viewModel: SettingsViewModelProtocol

    
    // MARK: - Coordinator
    init(_ rootController: UINavigationController,_ viewModel: SettingsViewModelProtocol) {
        self.rootController = rootController
        self.viewModel = viewModel
    }

    override func start() {
        openSettingsController()
        setupBindings()
        addChildCoordinator(self)
    }

    override func finish() {
        removeChildCoordinator(self)
        rootController.removeFromParent()
    }
    
    // MARK: - Navigation funcs
    private func openSettingsController() {
        let destinationView = SettingsView(code: "UAH",viewModel: viewModel)
        let viewController = UIHostingController(rootView: destinationView)
        rootController.tabBarItem = UITabBarItem(title: nil, image: TabBarItems.settings.image, tag: 3)
        rootController.pushViewController(viewController, animated: true)
    }
    
    func openSelectCurrency(selectedCode: String) {
        let destinationView = SelectCurrencyView(code: selectedCode,viewModel: viewModel)
        let viewController = UIHostingController(rootView: destinationView)
        viewController.hidesBottomBarWhenPushed = true
        rootController.pushViewController(viewController, animated: true)
    }
    
    private func setupBindings() {
        viewModel.selectedCurrencySubject
            .subscribe(onNext: { [weak self] currencyCode in
                self?.openSelectCurrency(selectedCode: currencyCode)
            })
            .disposed(by: bag)
    }


}
