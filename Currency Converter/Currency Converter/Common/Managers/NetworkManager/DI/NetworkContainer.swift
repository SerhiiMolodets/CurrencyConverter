//
//  NetworkContainer.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 10.08.2023.
//

import Foundation

import Swinject

extension Container {
    static let network: Container = {
        let container = Container()

        container.register(CurrencyNetworkProtocol.self) { _ in
            NetworkManager()
        }
        container.register(BidsNetworkProtocol.self) { _ in
            NetworkManager()
        }
        container.register(WalletNetworkProtocol.self) { _ in
            NetworkManager()
        }

        return container
    }()
}
