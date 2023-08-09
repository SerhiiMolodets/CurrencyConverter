//
//  BidsContainer.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 08.08.2023.
//

import Foundation
import Swinject

extension Container {
    static let bids: Container = {
        let container = Container()

        container.register(BidsViewModelProtocol.self) { _ in
            BidsViewModel()
        }

        return container
    }()
}
