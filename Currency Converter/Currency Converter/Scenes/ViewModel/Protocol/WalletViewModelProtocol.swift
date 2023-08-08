//
//  WalletViewModelProtocol.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 07.08.2023.
//

import Foundation
import RxSwift

protocol WalletViewModelProtocol {
    var addCurrencySubject: PublishSubject<Void> { get }
    var backSubject: PublishSubject<Void> { get }
    var selectSubject: PublishSubject<Void> { get }
    var countries: Observable<CountryCurrencies> { get }
    var selectedCountry: PublishSubject<(String, CurrencyCodeAndName)> { get }
    var walletData: PublishSubject<[WalletModel]> { get }
    var currentCode: String { get set }
    
    func addCurrency(code: String, amount: Double) async throws
}
