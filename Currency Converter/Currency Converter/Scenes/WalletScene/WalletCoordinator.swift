//
//  WalletCoordinator.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 04.08.2023.
//

import UIKit

class WalletCoordinator: Coordinator {
    
    // MARK: - Properties
    let rootController: UINavigationController
    var viewModel: WalletViewModelProtocol
    
    // MARK: - Coordinator
    init(_ rootController: UINavigationController, _ viewModel: WalletViewModelProtocol) {
        self.rootController = rootController
        self.viewModel = viewModel
        
    }

    override func start() {
        openWalletController()
        addChildCoordinator(self)
        setupBindings()
    }
    
    override func finish() {
        removeChildCoordinator(self)
        rootController.removeFromParent()
    }
    
    // MARK: - Navigation funcs
    private func openWalletController() {
        let viewController = WalletViewController.instantiate(coordinator: self)
        viewController.viewModel = viewModel
        rootController.tabBarItem = UITabBarItem(title: nil, image: TabBarItems.wallet.image, tag: 1)
        rootController.pushViewController(viewController, animated: true)
    }
    private func openAddCurrencyController() {
        let viewController = AddCurrencyViewController.instantiate(coordinator: self)
        viewController.viewModel = viewModel
        rootController.pushViewController(viewController, animated: true)
    }
    private func openSelectController() {
        let viewController = SelectViewController.instantiate(coordinator: self)
        viewController.viewModel = viewModel
        rootController.pushViewController(viewController, animated: true)
    }
    private func backToPrevious() {
        rootController.popViewController(animated: true)
    }
    
    // MARK: - Bindings funcs
    private func setupBindings() {
        viewModel.addCurrencySubject
            .subscribe(onNext: { [weak self] _ in
                self?.openAddCurrencyController()
            })
            .disposed(by: bag)
        viewModel.backSubject
            .subscribe(onNext: { [weak self] _ in
                self?.backToPrevious()
            })
            .disposed(by: bag)
        viewModel.selectSubject
            .subscribe(onNext: { [weak self] _ in
                self?.openSelectController()
            })
            .disposed(by: bag)
    }

}
