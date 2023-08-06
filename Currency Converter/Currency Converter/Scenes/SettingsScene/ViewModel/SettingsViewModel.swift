//
//  SettingsViewModel.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 06.08.2023.
//

import Foundation
import RxSwift

class SettingsViewModel: SettingsViewModelProtocol, ObservableObject {
    var selectedCurrencySubject = PublishSubject<String>()
}
