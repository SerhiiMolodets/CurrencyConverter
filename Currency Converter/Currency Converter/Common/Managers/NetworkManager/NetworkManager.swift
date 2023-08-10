//
//  NetworkManager.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 10.08.2023.
//

import Foundation
 
class NetworkManager: CurrencyNetworkProtocol, WalletNetworkProtocol, BidsNetworkProtocol {
    
    func getRates(for code: String) async throws -> CurencyListResponceSuccess {
        guard let url = URL(string: Api.currencyList.rawValue + code) else { throw NetworkError.invalidURL }
        let (data, _) = try await URLSession.shared.data(from: url)
        let responce = try JSONDecoder().decode(CurencyListResponceSuccess.self, from: data)
        return responce
    }
    
    func getUsdAmount(code: String, amount: Double) async throws -> Double {
        guard let url = URL(string: Api.pairCurrencyis.rawValue + "\(code)/USD") else { throw NetworkError.invalidURL }
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(UsdRateModel.self, from: data)
        let usdAmount = response.conversionRate * amount
        return usdAmount
    }
    
    func getBidAmount(from: String, to: String, amount: Double) async throws -> Double {
        guard let url = URL(string: Api.pairCurrencyis.rawValue + from + "/" + to) else { throw NetworkError.invalidURL }
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(UsdRateModel.self, from: data)
        let amount = response.conversionRate * amount
        return amount
    }
}
