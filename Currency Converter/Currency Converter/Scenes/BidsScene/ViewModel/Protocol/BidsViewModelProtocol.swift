//
//  BidsViewModelProtocol.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 08.08.2023.
//

import Foundation
import RxRelay
import RxSwift


protocol BidsViewModelProtocol: SelectViewModelProtocol {
    var addBidSubject: PublishSubject<Void> { get }
    var searchText: BehaviorRelay<String> { get }
    var backSubject: PublishSubject<Void> { get }
    var selectSubject: PublishSubject<Void> { get }
    var target: Target { get set }
    var selectedCountry: PublishSubject<(String, CurrencyCodeAndName)> { get }
    var currentCode: String { get set }
}
