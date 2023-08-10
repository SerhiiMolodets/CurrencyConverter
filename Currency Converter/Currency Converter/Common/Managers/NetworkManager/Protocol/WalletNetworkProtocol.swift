//
//  WalletNetworkProtocol.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 10.08.2023.
//

import Foundation

protocol WalletNetworkProtocol {
    func getUsdAmount(code: String, amount: Double) async throws -> Double
}
