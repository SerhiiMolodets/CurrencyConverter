//
//  CurrencyListContainer.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 06.08.2023.
//

import Foundation
import Swinject

extension Container {
    static let currencyList: Container = {
        let container = Container()

        container.register(CurrencyListViewModel.self) { _ in
            CurrencyListViewModel()
        }

        return container
    }()
}
