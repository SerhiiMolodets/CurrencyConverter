//
//  AddCurrencyViewController.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 07.08.2023.
//

import UIKit
import RxSwift
import RxCocoa

class AddCurrencyViewController: BaseViewController, Storyboarded {
    
    // MARK: - Properties
    var viewModel: WalletViewModelProtocol!

   
    
    // MARK: - IBOutlets
    @IBOutlet weak var topTitleLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var selectCountyLabel: UILabel!
    @IBOutlet weak var countyContainerView: UIView!
    @IBOutlet weak var flagView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    // MARK: - Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        configureUI()
        addTapGesture()
        setupBindings()
        checkInput()
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
        countryLabel.text = "No Country Selected"
        countryLabel.font = UIFont(name: "Montserrat-SemiBold", size: 17)
        amountTextField.placeholder = "Enter Owned Currency Value"
        amountTextField.keyboardType = .numberPad
        amountTextField.textColor = .tabBarSelected
        countyContainerView.layer.cornerRadius = 16
        countyContainerView.layer.borderWidth = 1
        countyContainerView.layer.borderColor = UIColor.tabBarUnselected.cgColor
        flagView.image = UIImage(named: "Ellipse")
        currencyLabel.text = "--"
        currencyLabel.font = UIFont(name: "Montserrat-Regular", size: 17)
        currencyLabel.textColor = .tabBarUnselected
        addButton.backgroundColor = .tabBarUnselected
        addButton.layer.cornerRadius = 8
        addButton.tintColor = .white
    }
    
    private func addTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: nil, action: nil)
        countyContainerView.addGestureRecognizer(tapGestureRecognizer)
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
                self.flagView.image = UIImage(named: item.1.currencyCode)
                self.countryLabel.text = item.0
                self.currencyLabel.text = item.1.currencyName + " (\(item.1.currencyCode))"
                self.viewModel.currentCode = item.1.currencyCode
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
        amountTextField.rx.text.orEmpty
            .map { !$0.isEmpty }
                        .subscribe(onNext: { isValid in
                            if isValid,
                               self.countryLabel.text != "No Country Selected"{
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