//
//  SelectViewController.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 07.08.2023.
//

import UIKit
import RxSwift
import RxCocoa

class SelectViewController: BaseViewController, Storyboarded {
    
    // MARK: - Properties
    var viewModel: WalletViewModelProtocol!
    
    // MARK: - IBOutlets
    @IBOutlet weak var selectTableView: UITableView! {
        didSet {
            selectTableView.register(UINib(nibName: "CountryTableViewCell", bundle: nil), forCellReuseIdentifier: "CountryTableViewCell")
        }
    }
    
    // MARK: - Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
    }
    
    // MARK: - Flow funcs
    private func setupNavBar() {
        navigationItem.hidesBackButton = true
        setupBackNavBar(title: "Select Country") { [weak self] in
            self?.viewModel.backSubject.onNext(())
        }
    }
    
    private func setupTableView() {
        viewModel.countries
            .bind(to: selectTableView.rx.items(cellIdentifier: "CountryTableViewCell", cellType: CountryTableViewCell.self)) { index, item, cell in
                cell.configure(code: item.value.currencyCode, country: item.key, currency: item.value.currencyName)
            }
            .disposed(by: bag)
        
        let selectedItemObservable = selectTableView.rx.modelSelected((String, CurrencyCodeAndName).self)
        selectedItemObservable
            .bind(to: viewModel.selectedCountry)
            .disposed(by: bag)
        
        selectedItemObservable
            .subscribe { [weak self] _ in
                self?.viewModel.backSubject.onNext(())
            }.disposed(by: bag)
    }
    
}
