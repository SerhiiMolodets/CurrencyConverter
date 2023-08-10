//
//  RealmManagerBidProtocol.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 10.08.2023.
//

import Foundation

protocol RealmManagerBidProtocol {
    func saveBidModel(_ model: BidModel)
    func loadBidModels(completion: @escaping([BidModel]) -> Void)
    func cleanAll()
}
