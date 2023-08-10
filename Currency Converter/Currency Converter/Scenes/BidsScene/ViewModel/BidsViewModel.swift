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
    var fromCode: String = ""
    var toCode: String = ""
    var bidsData = PublishSubject<[BidModel]>()
    
    var realmManager: RealmManagerBidProtocol!
    
    var selectedCountry = PublishSubject<(String, CurrencyCodeAndName)>()
    
    func addBid(fromCode: String, toCode: String, amount: Double) async throws {
        do {
            let toAmount = try await getBidAmount(amount: amount)
            let data = BidModel(fromCode: fromCode, toCode: toCode, fromAmount: amount, toAmmount: toAmount)
            save(model: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func getBidAmount(amount: Double) async throws -> Double {
        guard let url = URL(string: "https://v6.exchangerate-api.com/v6/7edcef7c0bb1f72a47090f30/pair/\(fromCode)/\(toCode)") else { return 0 }
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(UsdRateModel.self, from: data)
        let amount = response.conversionRate * amount
        return amount
    }
    func initData() {
        fetch()
    }
    func save(model: BidModel) {
        realmManager.saveBidModel(model)
        fetch()
    }
    
    private func fetch() {
        realmManager.loadBidModels { loaded in
            self.bidsData.onNext(loaded)
        }
    }
}

enum Target {
    case from, to
}
