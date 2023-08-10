//
//  CurrencyNetworkProtocol.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 10.08.2023.
//

import Foundation

protocol CurrencyNetworkProtocol {
    func getRates(for code: String) async throws -> CurencyListResponceSuccess
}
