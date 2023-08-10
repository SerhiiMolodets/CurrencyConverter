//
//  WalletViewModel.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 07.08.2023.
//

import Foundation
import RxSwift
import RxRelay


class WalletViewModel: WalletViewModelProtocol {
    
    var addCurrencySubject = PublishSubject<Void>()
    var searchText: BehaviorRelay<String> = BehaviorRelay(value: "")
    var backSubject = PublishSubject<Void>()
    var selectSubject = PublishSubject<Void>()
    var selectedCountry = PublishSubject<(String, CurrencyCodeAndName)>()
    var walletData = PublishSubject<[WalletModel]>()
    private var currentWalletArray: [WalletModel] = []
    var currentCode: String = ""
    
    var realmManager: RealmManagerWalletProtocol!
    var networkManager: WalletNetworkProtocol!
    
    
    
    func addCurrency(code: String, amount: Double) async throws {
        do {
            let usdAmount = try await getUsdAmount(code: code, amount: amount)
            let data = WalletModel(code: code, amount: amount, usdAmmount: usdAmount)
            realmManager.saveWalletModels(walletModels: data)
            fetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func getUsdAmount(code: String, amount: Double) async throws -> Double {
        try await networkManager.getUsdAmount(code: code, amount: amount)
    }

    
    func initData() {
        fetch()
    }
    
    private func fetch() {
        realmManager.loadWalletModels { loaded in
            self.walletData.onNext(loaded)
        }
    }
    
}
