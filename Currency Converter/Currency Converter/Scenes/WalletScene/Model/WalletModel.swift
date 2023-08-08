//
//  WalletModel.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 07.08.2023.
//

import Foundation

class WalletModel {
    let code: String
    let amount: Double
    var usdAmmount: Double
    var stringAmount: String {
        return String(format: "%.2f", amount)
    }
    
    init(code: String, amount: Double, usdAmmount: Double) {
        self.code = code
        self.amount = amount
        self.usdAmmount = usdAmmount
    }
}
