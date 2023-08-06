//
//  SettingViewModelProtocol.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 06.08.2023.
//

import Foundation
import RxSwift

protocol SettingsViewModelProtocol {
    var selectedCurrencySubject: PublishSubject<Void> { get }
    var listData: [CurrencyCodeAndName]  { get }
    var savedCode: String { get set }
    
    func saveSelected(currency: String)
    func loadSelectedCurrency()
    func isSelected(_ code: String) -> Bool
}
