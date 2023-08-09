//
//  WalletViewController.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 04.08.2023.
//

import UIKit
import RxSwift

class WalletViewController: BaseViewController {
    
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
        viewModel.initData()
        setupBalanceLabel()
    }
    
    // MARK: - Flow funcs
    private func configureUI () {
        subTitleLabel.text = "Total Balance"
        subTitleLabel.textColor = .tabBarUnselected
        subTitleLabel.font = UIFont(name: "Inter-Medium", size: 20)
        balanceLabel.font = UIFont(name: "Inter-Medium", size: 48)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    private func setupNavBar () {
        setupNavBar(title: "Wallet") { [weak self] in
            self?.viewModel.addCurrencySubject.onNext(())
        } searchHandler: { [weak self] searchtext in
            self?.viewModel.searchText.accept(searchtext)
        }
    }
    private func setupTableView() {
        Observable.combineLatest(viewModel.walletData, viewModel.searchText)
            .map { walletData, searchText in
                if searchText.isEmpty {
                    return walletData
                } else {
                    return walletData.filter { $0.code.lowercased().contains(searchText.lowercased()) }
                }
            }
            .bind(to: waletTableView.rx.items(cellIdentifier: "WalletTableViewCell", cellType: WalletTableViewCell.self)) { index, item, cell in
                cell.configure(item)
            }
            .disposed(by: bag)
    }
    
    private func setupBalanceLabel() {
        viewModel.walletData
            .map { walletData in
                walletData.reduce(0) { $0 + $1.usdAmmount }
            }
            .map { String(format: "%.2f", $0) }
            .map { "USD".getSymbolForCurrencyCode() + $0 }
            .map { $0.createAttributedText() }
            .bind(to: balanceLabel.rx.attributedText)
            .disposed(by: bag)
    }
}
