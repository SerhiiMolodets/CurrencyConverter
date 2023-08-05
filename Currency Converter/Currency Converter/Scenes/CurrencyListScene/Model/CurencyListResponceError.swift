//
//  CurencyListResponceError.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 05.08.2023.
//

import Foundation

struct CurencyListResponceError: Codable {
    let result, errorType: String

    enum CodingKeys: String, CodingKey {
        case result
        case errorType = "error-type"
    }
}
