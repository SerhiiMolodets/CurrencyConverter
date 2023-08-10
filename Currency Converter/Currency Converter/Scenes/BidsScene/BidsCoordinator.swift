//
//  BidsCoordinator.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 04.08.2023.
//

import UIKit
import Swinject

class BidsCoordinator: Coordinator {
    
    // MARK: - Properties
    let rootController: UINavigationController
    var viewModel: BidsViewModelProtocol
    
    // MARK: - Coordinator
    init(_ rootController: UINavigationController, _ viewModel: BidsViewModelProtocol) {
        self.rootController = rootController
        self.viewModel = viewModel
        
    }

    override func start() {
        openBidsController()
        addChildCoordinator(self)
        setupBindings()
        guard let realmManager = Container.realm.resolve(RealmManagerBidProtocol.self) else { return }
        viewModel.realmManager = realmManager
    }
    
    override func finish() {
        removeChildCoordinator(self)
        rootController.removeFromParent()
    }
    
    // MARK: - Navigation funcs
    private func openBidsController() {
        let viewController = BidsViewController.instantiate(coordinator: self)
        viewController.viewModel = viewModel
        rootController.tabBarItem = UITabBarItem(title: nil, image: TabBarItems.bids.image, tag: 2)
        rootController.pushViewController(viewController, animated: true)
    }

    private func openAddBidController() {
        let viewController = AddBidViewController.instantiate(coordinator: self)
        viewController.viewModel = viewModel
        rootController.pushViewController(viewController, animated: true)
    }
    private func backToPrevious() {
        rootController.popViewController(animated: true)
    }
    private func openSelectController() {
        let viewController = SelectViewController.instantiate(coordinator: self)
        viewController.viewModel = viewModel
        rootController.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Bindings funcs
    private func setupBindings() {
        viewModel.addBidSubject
            .subscribe(onNext: { [weak self] _ in
                self?.openAddBidController()
            })
            .disposed(by: bag)
        viewModel.backSubject
            .subscribe(onNext: { [weak self] _ in
                self?.backToPrevious()
            }).disposed(by: bag)
        viewModel.selectSubject
            .subscribe(onNext: { [weak self] _ in
                self?.openSelectController()
            })
            .disposed(by: bag)
    }
}
