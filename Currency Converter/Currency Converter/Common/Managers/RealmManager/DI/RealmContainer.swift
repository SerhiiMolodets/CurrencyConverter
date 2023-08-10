//
//  RealmContainer.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 08.08.2023.
//

import Foundation

import Swinject

extension Container {
    static let realm: Container = {
        let container = Container()

        container.register(RealmManagerWalletProtocol.self) { _ in
            RealmManager()
        }
        container.register(RealmManagerBidProtocol.self) { _ in
            RealmManager()
        }

        return container
    }()
}
