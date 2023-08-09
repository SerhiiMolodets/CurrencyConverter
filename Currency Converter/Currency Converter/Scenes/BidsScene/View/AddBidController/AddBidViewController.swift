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
    // MARK: - IBOutlets
    @IBOutlet weak var topTitleLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var fromCountryView: SelectCountryView!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var toCountryView: SelectCountryView!
    @IBOutlet weak var addButton: UIButton!
    
    
    
    // MARK: - Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        configureUI()
        setupBindings()
        addTapGesture()
        checkInput()
    }
    // MARK: - Flow funcs
    private func setupNavBar() {
        navigationItem.hidesBackButton = true
        setupBackNavBar(title: "Add Bid") { [weak self] in
            self?.viewModel.backSubject.onNext(())
        }
    }
    
    private func configureUI() {
        topTitleLabel.text = "Bid Value (CAD)"
        topTitleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 17)
        fromLabel.text = "Select Country Currency (From)"
        fromLabel.font = UIFont(name: "Montserrat-SemiBold", size: 17)
        toLabel.text = "Select Country Currency (To)"
        toLabel.font = UIFont(name: "Montserrat-SemiBold", size: 17)
        addButton.backgroundColor = .tabBarUnselected
        addButton.layer.cornerRadius = 8
        addButton.tintColor = .white
        amountTextField.placeholder = "Enter Bid Value"
        amountTextField.keyboardType = .numberPad
        amountTextField.textColor = .tabBarSelected
    }
    
    private func addTapGesture() {
        let fromTapGestureRecognizer = UITapGestureRecognizer(target: nil, action: nil)
        fromCountryView.addGestureRecognizer(fromTapGestureRecognizer)
        fromTapGestureRecognizer.rx.event
              .subscribe(onNext: { [weak self] _ in
                  self?.viewModel.selectSubject.onNext(())
                  self?.viewModel.target = .from
              })
              .disposed(by: bag)
        
        let toTapGestureRecognizer = UITapGestureRecognizer(target: nil, action: nil)
        toCountryView.addGestureRecognizer(toTapGestureRecognizer)
        toTapGestureRecognizer.rx.event
              .subscribe(onNext: { [weak self] _ in
                  self?.viewModel.selectSubject.onNext(())
                  self?.viewModel.target = .to
              })
              .disposed(by: bag)
    }
    private func setupBindings() {
        viewModel.selectedCountry
            .subscribe(onNext:  { [weak self] item in
                guard let self else { return }
                switch viewModel.target {
                case .from:
                    fromCountryView.configure(country: item.0, currency: item.1.currencyName, code: item.1.currencyCode)
                case .to:
                    toCountryView.configure(country: item.0, currency: item.1.currencyName, code: item.1.currencyCode)
                }
               
            }).disposed(by: bag)
        let buttonObserver = addButton.rx.tap
        buttonObserver
            .bind(to: viewModel.backSubject)
            .disposed(by: bag)
        buttonObserver
            .subscribe { [weak self] _ in
                guard let self else { return }
//                Task {
//                    if let amountString = self.amountTextField.text,
//                    let amount = Double(amountString) {
//                        try? await self.viewModel.addCurrency(code: self.viewModel.currentCode,amount: amount)
//                    }
//                }
         
            }.disposed(by: bag)
        
    }
    
    private func checkInput() {
        amountTextField.rx.text.orEmpty
            .map { !$0.isEmpty }
                        .subscribe(onNext: { isValid in
                            if isValid,
                               self.fromCountryView.isSelected,
                               self.toCountryView.isSelected {
                                self.addButton.backgroundColor = UIColor(red: 0.178, green: 0.251, blue: 0.508, alpha: 1)
                                self.addButton.isEnabled = true
                            } else {
                                self.addButton.backgroundColor = .tabBarUnselected
                                self.addButton.isEnabled = false
                            }
                        })
                        .disposed(by: bag)
    }
    
}
