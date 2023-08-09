//
//  SelectViewController.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 07.08.2023.
//

import UIKit
import RxSwift
import RxCocoa

class SelectViewController: BaseViewController {
    
    // MARK: - Properties
    var viewModel: SelectViewModelProtocol!
    
    // MARK: - IBOutlets
    @IBOutlet weak var selectTableView: UITableView! {
        didSet {
            selectTableView.register(UINib(nibName: "CountryTableViewCell", bundle: nil), forCellReuseIdentifier: "CountryTableViewCell")
        }
    }
    
    // MARK: - Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        configuredUI()
        setupNavBar()
        setupTableView()
    }
    
    // MARK: - Flow funcs
    private func setupNavBar() {
        
        setupBackNavBar(title: "Select Country") { [weak self] in
            self?.viewModel.backSubject.onNext(())
        }
    }
    
    private func configuredUI() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func setupTableView() {
        Observable.just(CountryManager.shared.currencyData)
            .map { countries in
                countries.sorted { $0.key < $1.key }
            }
            .bind(to: selectTableView.rx.items(cellIdentifier: "CountryTableViewCell", cellType: CountryTableViewCell.self)) { index, item, cell in
                cell.configure(code: item.value.currencyCode, country: item.key, currency: item.value.currencyName)
            }
            .disposed(by: bag)
        
        let selectedItemObservable = selectTableView.rx.modelSelected((String, CurrencyCodeAndName).self)
        selectedItemObservable
            .bind(to: viewModel.selectedCountry)
            .disposed(by: bag)
        
        selectedItemObservable
            .subscribe { [weak self] item in
                self?.viewModel.backSubject.onNext(())
            }.disposed(by: bag)
    }
    
}
