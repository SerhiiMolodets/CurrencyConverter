//
//  BidsViewController.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 04.08.2023.
//

import UIKit
import RxSwift
import RxCocoa

class BidsViewController: BaseViewController {
    
    // MARK: - Properties
    var viewModel: BidsViewModelProtocol!
    
    // MARK: - IBOutlets
    @IBOutlet weak var bidsTableView: UITableView! {
        didSet {
            bidsTableView.register(UINib(nibName: "BidsTableViewCell", bundle: nil), forCellReuseIdentifier: "BidsTableViewCell")
        }
    }
    
    // MARK: - Lifecycle funcs
    override func viewDidLoad() {
        configureUI()
        setupNavBar()
        setupTableView()
        viewModel.initData()
    }
    
    private func setupNavBar () {
        setupNavBar(title: "Bids") { [weak self] in
            self?.viewModel.addBidSubject.onNext(())
        } searchHandler: { [weak self] searchtext in
            self?.viewModel.searchText.accept(searchtext)
        }

    }
    private func configureUI() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        bidsTableView.separatorStyle = .none
    }
    
    private func setupTableView() {
        Observable.combineLatest(viewModel.bidsData, viewModel.searchText)
            .map { bidsData, searchText in
                if searchText.isEmpty {
                    return bidsData
                } else {
                    return bidsData.filter { ($0.fromCode + $0.toCode).lowercased().contains(searchText.lowercased()) }
                }
            }
            .bind(to: bidsTableView.rx.items(cellIdentifier: "BidsTableViewCell", cellType: BidsTableViewCell.self)) { index, item, cell in
                cell.configure(item)
                if index > 0 {
                    cell.addSeparator()
                }
            }
            .disposed(by: bag)
        
        bidsTableView.rx.modelSelected(BidModel.self)
            .subscribe(onNext: { [weak self] model in
                self?.viewModel.save(model: model)
            })
            .disposed(by: bag)
    }  
}
