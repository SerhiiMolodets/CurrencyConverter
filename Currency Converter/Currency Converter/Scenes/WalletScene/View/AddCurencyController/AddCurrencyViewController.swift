//
//  AddCurrencyViewController.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 07.08.2023.
//

import UIKit
import RxSwift
import RxCocoa

class AddCurrencyViewController: BaseViewController {
    
    // MARK: - Properties
    var viewModel: WalletViewModelProtocol!

    // MARK: - IBOutlets
    @IBOutlet weak var topTitleLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var selectCountyLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var selectCountryView: SelectCountryView!
    // MARK: - Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        configureUI()
        addTapGesture()
        setupBindings()
        checkInput()
        setupDismissKeyboardGesture()
    }

    // MARK: - Flow funcs
    private func setupNavBar() {
        navigationItem.hidesBackButton = true
        setupBackNavBar(title: "Add Owned Currency") { [weak self] in
            self?.viewModel.backSubject.onNext(())
        }
    }
    
    private func configureUI() {
        topTitleLabel.text = "Owned Value"
        topTitleLabel.font = UIFont(name: "Montserrat-SemiBold", size: 17)
        selectCountyLabel.text = "Select Country Currency"
        selectCountyLabel.font = UIFont(name: "Montserrat-SemiBold", size: 17)
        amountTextField.placeholder = "Enter Owned Currency Value"
        amountTextField.keyboardType = .numberPad
        amountTextField.textColor = .tabBarSelected
        addButton.backgroundColor = .tabBarUnselected
        addButton.layer.cornerRadius = 8
        addButton.tintColor = .white
    }
    
    private func addTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: nil, action: nil)
        selectCountryView.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.rx.event
              .subscribe(onNext: { [weak self] _ in
                  self?.viewModel.selectSubject.onNext(())
              })
              .disposed(by: bag)
    }
    
    private func setupBindings() {
        viewModel.selectedCountry
            .subscribe(onNext:  { [weak self] item in
                guard let self else { return }
                viewModel.currentCode = item.1.currencyCode
                selectCountryView.configure(country: item.0, currency: item.1.currencyName, code: item.1.currencyCode)
            }).disposed(by: bag)
        let buttonObserver = addButton.rx.tap
        buttonObserver
            .bind(to: viewModel.backSubject)
            .disposed(by: bag)
        buttonObserver
            .subscribe { [weak self] _ in
                guard let self else { return }
                Task {
                    if let amountString = self.amountTextField.text,
                    let amount = Double(amountString) {
                        try? await self.viewModel.addCurrency(code: self.viewModel.currentCode,amount: amount)
                    }
                }
         
            }.disposed(by: bag)
        
    }
    
    private func checkInput() {
        let inputObservable = amountTextField.rx.text.orEmpty
              .map { !$0.isEmpty }

          let selectObservable = viewModel.selectedCountry

          Observable.combineLatest(inputObservable, selectObservable)
              .subscribe(onNext: { [weak self] isValid, isSelected in
                  self?.updateButtonState(isValid: isValid, isSelected: self!.selectCountryView.isSelected)
              })
              .disposed(by: bag)
    }
    private func updateButtonState(isValid: Bool, isSelected: Bool) {
        if isValid, isSelected {
            self.addButton.backgroundColor = .addBlue
            self.addButton.isEnabled = true
        } else {
            self.addButton.backgroundColor = .tabBarUnselected
            self.addButton.isEnabled = false
        }
    }
}
