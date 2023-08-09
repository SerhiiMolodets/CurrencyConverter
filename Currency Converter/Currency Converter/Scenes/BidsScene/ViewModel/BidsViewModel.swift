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
    
}
