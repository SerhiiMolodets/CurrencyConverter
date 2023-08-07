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
    var savedCode = ""
    var filtered: [String: Double] {
        guard !searchQuery.isEmpty else { return conversionRates }
        
        return conversionRates.filter { currency in
            currency.key.lowercased().contains(searchQuery.lowercased())
        }
    }
    
    init() {
        fetch()
    }
    
    
    private func getRates() async throws {
        guard let url = URL(string: "https://v6.exchangerate-api.com/v6/7edcef7c0bb1f72a47090f30/latest/\(savedCode)") else { return }
        let (data, _) = try await URLSession.shared.data(from: url)
        let responce = try JSONDecoder().decode(CurencyListResponceSuccess.self, from: data)
        DispatchQueue.main.async {
            print("request")
            self.conversionRates = responce.conversionRates
            self.conversionRates.removeValue(forKey: self.savedCode)
            self.warningIsShowed = false
        }
    }
    
    func fetch() {
        if  savedCode != UserDefaults.standard.string(forKey: "selectedCurrency") ?? "UAH" {
            savedCode = UserDefaults.standard.string(forKey: "selectedCurrency") ?? "UAH"
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

