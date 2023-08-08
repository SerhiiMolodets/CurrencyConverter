//
//  CurrencyListModel.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 05.08.2023.
//

import Foundation

struct CurencyListResponceSuccess: Codable {

    let conversionRates: [String: Double]

    enum CodingKeys: String, CodingKey {
        case conversionRates = "conversion_rates"
    }
}
