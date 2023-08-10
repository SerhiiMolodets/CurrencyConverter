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
    var fromCode: String { get set }
    var toCode: String { get set }
    var bidsData: PublishSubject<[BidModel]> { get set }
    var realmManager: RealmManagerBidProtocol! {  get set }
    var networkManager: BidsNetworkProtocol! {  get set }
    
    func initData()
    func addBid(fromCode: String, toCode: String, amount: Double) async throws
    func save(model: BidModel) 
}
