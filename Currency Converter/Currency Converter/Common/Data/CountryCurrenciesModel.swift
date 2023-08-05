//
//  CurrencyCountriesModel.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 05.08.2023.
//

import Foundation

struct CurrencyCodeAndName: Codable {
    let currencyCode, currencyName: String

    enum CodingKeys: String, CodingKey {
        case currencyCode = "Currency Code"
        case currencyName = "Currency Name"
    }
}

typealias CountryCurrencies = [String: CurrencyCodeAndName]
