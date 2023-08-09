//
//  BidsViewController.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 04.08.2023.
//

import UIKit

class BidsViewController: BaseViewController {
    
    // MARK: - Properties
    var viewModel: BidsViewModelProtocol!
    
    // MARK: - IBOutlets
    @IBOutlet weak var bidsTableView: UITableView!
    
    // MARK: - Lifecycle funcs
    override func viewDidLoad() {
        setupNavBar()
    }
    
    private func setupNavBar () {
        setupNavBar(title: "Bids") { [weak self] in
            self?.viewModel.addBidSubject.onNext(())
        } searchHandler: { [weak self] searchtext in
            self?.viewModel.searchText.accept(searchtext)
        }
    }
    
}
