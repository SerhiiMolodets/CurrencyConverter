//
//  BidsViewModelProtocol.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 08.08.2023.
//

import Foundation
import RxRelay
import RxSwift


protocol BidsViewModelProtocol {
    var addBidSubject: PublishSubject<Void> { get }
    var searchText: BehaviorRelay<String> { get }
    var backSubject: PublishSubject<Void> { get }
}
