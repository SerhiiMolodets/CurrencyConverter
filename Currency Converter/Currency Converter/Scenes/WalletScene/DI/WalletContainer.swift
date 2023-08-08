//
//  WalletContainer.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 07.08.2023.
//

import Foundation
import Swinject

extension Container {
    static let wallet: Container = {
        let container = Container()

        container.register(WalletViewModelProtocol.self) { _ in
            WalletViewModel()
        }

        return container
    }()
}
