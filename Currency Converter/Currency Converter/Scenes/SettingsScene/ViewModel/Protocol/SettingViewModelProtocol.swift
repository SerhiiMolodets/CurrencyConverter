//
//  SettingViewModelProtocol.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 06.08.2023.
//

import Foundation
import RxSwift

protocol SettingsViewModelProtocol {
    var selectedCurrencySubject: PublishSubject<String> { get }
}
