//
//  SettingsContainer.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 06.08.2023.
//

import Foundation
import Swinject

extension Container {
    static let settings: Container = {
        let container = Container()

        container.register(SettingsViewModelProtocol.self) { _ in
            SettingsViewModel()
        }

        return container
    }()
}
