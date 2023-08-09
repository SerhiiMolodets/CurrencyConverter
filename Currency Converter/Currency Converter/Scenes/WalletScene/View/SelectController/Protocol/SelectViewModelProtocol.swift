//
//  SelectViewModelProtocol.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 09.08.2023.
//

import Foundation
import RxSwift

protocol SelectViewModelProtocol {
    var backSubject: PublishSubject<Void> { get }
    var selectedCountry: PublishSubject<(String, CurrencyCodeAndName)> { get }
    var currentCode: String { get set }
}
