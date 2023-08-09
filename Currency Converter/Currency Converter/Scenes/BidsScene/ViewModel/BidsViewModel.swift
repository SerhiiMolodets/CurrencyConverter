//
//  BidsViewModel.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 08.08.2023.
//

import Foundation
import RxSwift
import RxRelay

class BidsViewModel: BidsViewModelProtocol {
    var addBidSubject = PublishSubject<Void>()
    var searchText: BehaviorRelay<String> = BehaviorRelay(value: "")
    var backSubject = PublishSubject<Void>()
    var selectSubject = PublishSubject<Void>()
    var target: Target = .from
    var currentCode: String = ""

    var selectedCountry = PublishSubject<(String, CurrencyCodeAndName)>()
    
}

enum Target {
    case from, to
}
