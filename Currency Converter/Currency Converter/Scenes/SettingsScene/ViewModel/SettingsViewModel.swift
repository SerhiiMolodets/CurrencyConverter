//
//  SettingsViewModel.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 06.08.2023.
//

import Foundation
import RxSwift

class SettingsViewModel: SettingsViewModelProtocol, ObservableObject {

    var selectedCurrencySubject = PublishSubject<Void>()
    var savedCode = UserDefaults.standard.string(forKey: "selectedCurrency") ?? "UAH"
    
    var listData: [CurrencyCodeAndName] {
        return Array(CountryManager.shared.currencyData.values)
    }
    
    func saveSelected(currency: String) {
        UserDefaults.standard.set(currency, forKey: "selectedCurrency")
    }
    func loadSelectedCurrency() {
        savedCode = UserDefaults.standard.string(forKey: "selectedCurrency") ?? "UAH"
    }
    
    func isSelected(_ code: String) -> Bool {
        savedCode == code
    }
}
