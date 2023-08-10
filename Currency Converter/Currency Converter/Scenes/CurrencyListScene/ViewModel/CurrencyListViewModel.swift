//
//  CurrencyListViewModel.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 05.08.2023.
//

import SwiftUI


class CurrencyListViewModel: ObservableObject {
    
    @Published var conversionRates: [String: Double] = [:]
    @Published var searchQuery: String = ""
    @Published var warningIsShowed: Bool = false
    
    var networkManager: CurrencyNetworkProtocol!
    var savedCode = ""
    var filtered: [String: Double] {
        guard !searchQuery.isEmpty else { return conversionRates }
        
        return conversionRates.filter { currency in
            currency.key.lowercased().contains(searchQuery.lowercased())
        }
    }
    
 
    private func getRates() async throws {
        let responce = try await networkManager.getRates(for: savedCode)
        DispatchQueue.main.async {
            self.conversionRates = responce.conversionRates
            self.conversionRates.removeValue(forKey: self.savedCode)
            self.warningIsShowed = false
        }
    }
    
    func fetch() {
        let loadedCode = UserDefaults.standard.string(forKey: "selectedCurrency") ?? "UAH"
        if  savedCode != loadedCode {
            savedCode = loadedCode
            Task {
                do {
                    try await getRates()
                } catch {
                    DispatchQueue.main.async {
                        self.warningIsShowed = true
                    }
                    print(error)
                }
            }
        }
    }
}

