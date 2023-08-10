//
//  WalletViewModelProtocol.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 07.08.2023.
//

import Foundation
import RxSwift
import RxRelay

protocol WalletViewModelProtocol: SelectViewModelProtocol {
    var addCurrencySubject: PublishSubject<Void> { get }
    var searchText: BehaviorRelay<String> { get }
    var selectSubject:PublishSubject<Void> { get }
    var walletData: PublishSubject<[WalletModel]> { get }
    var currentCode: String { get set }
    var realmManager: RealmManagerWalletProtocol! { get set }
    var networkManager: WalletNetworkProtocol! { get set }
    
    func addCurrency(code: String, amount: Double) async throws
    func initData()
}
