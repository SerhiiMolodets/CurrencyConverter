//
//  WalletViewController.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 04.08.2023.
//

import UIKit

class WalletViewController: BaseViewController, Storyboarded {
    
    // MARK: - Properties
    var viewModel: WalletViewModelProtocol!
    
    // MARK: - IBOutlets
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var waletTableView: UITableView! {
        didSet {
            waletTableView.register(UINib(nibName: "WalletTableViewCell", bundle: nil), forCellReuseIdentifier: "WalletTableViewCell")
        }
    }
    
    // MARK: - Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        configureUI()
        setupTableView()
    }
    
    // MARK: - Flow funcs
    private func configureUI () {
        subTitleLabel.text = "Total Balance"
        subTitleLabel.textColor = .tabBarUnselected
        subTitleLabel.font = UIFont(name: "Inter-Medium", size: 20)
        balanceLabel.font = UIFont(name: "Inter-Medium", size: 48)
        
    }
    private func setupNavBar () {
        setupNavBar(title: "Wallet") { [weak self] in
            self?.viewModel.addCurrencySubject.onNext(())
        } searchHandler: { searchtext in
            print(searchtext)
        }
    }
    private func setupTableView() {
        viewModel.walletData
            .bind(to: waletTableView.rx.items(cellIdentifier: "WalletTableViewCell", cellType: WalletTableViewCell.self)) { index, item, cell in
                cell.configure(item)
            }
            .disposed(by: bag)
    }
}
