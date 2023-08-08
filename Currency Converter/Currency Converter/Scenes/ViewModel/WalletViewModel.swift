//
//  WalletViewModel.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 07.08.2023.
//

import Foundation
import RxSwift

class WalletViewModel: WalletViewModelProtocol {
    var addCurrencySubject = PublishSubject<Void>()
    var backSubject = PublishSubject<Void>()
    var selectSubject = PublishSubject<Void>()
    var countries = Observable.just(CountryManager.shared.currencyData)
    var selectedCountry = PublishSubject<(String, CurrencyCodeAndName)>()
    var walletData = PublishSubject<[WalletModel]>()
    private var currentWalletArray: [WalletModel] = []
    var currentCode: String = ""
    
    
    
    
    func addCurrency(code: String, amount: Double) async throws {
        do {
            let usdAmount = try await getUsdAmount(code: code, amount: amount)
            let data = WalletModel(code: code, amount: amount, usdAmmount: usdAmount)
            
            currentWalletArray.append(data)
            walletData.onNext(currentWalletArray)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func getUsdAmount(code: String, amount: Double) async throws -> Double {
        guard let url = URL(string: "https://v6.exchangerate-api.com/v6/7edcef7c0bb1f72a47090f30/pair/\(code)/USD") else { return 0 }
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(UsdRateModel.self, from: data)
        let usdAmount = response.conversionRate * amount
        print(usdAmount)
        return usdAmount
    }
    
    
}
