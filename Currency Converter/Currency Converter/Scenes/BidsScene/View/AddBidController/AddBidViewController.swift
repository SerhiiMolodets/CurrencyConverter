//
//  AddBidViewController.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 08.08.2023.
//

import UIKit

class AddBidViewController: BaseViewController {
    
    // MARK: - Properties
    var viewModel: BidsViewModelProtocol!
    
    // MARK: - Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    // MARK: - Flow funcs
    private func setupNavBar() {
        navigationItem.hidesBackButton = true
        setupBackNavBar(title: "Add Bid") { [weak self] in
            self?.viewModel.backSubject.onNext(())
        }
    }
}
