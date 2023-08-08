//
//  WalletModel.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 07.08.2023.
//

import Foundation
import RealmSwift

class WalletModel: Object {
    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var code: String = ""
    @Persisted var amount: Double = 0.0
    @Persisted var usdAmmount: Double = 0.0
    
    var stringAmount: String {
        return String(format: "%.2f", amount)
    }
    
    convenience init(code: String, amount: Double, usdAmmount: Double) {
        self.init()
        self.code = code
        self.amount = amount
        self.usdAmmount = usdAmmount
    }
}
