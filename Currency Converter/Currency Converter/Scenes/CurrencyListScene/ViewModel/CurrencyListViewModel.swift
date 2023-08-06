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
    var savedCode = UserDefaults.standard.string(forKey: "selectedCurrency") ?? "UAH"
    var filtered: [String: Double] {
        guard !searchQuery.isEmpty else { return conversionRates }
        
        return conversionRates.filter { currency in
            currency.key.lowercased().contains(searchQuery.lowercased())
        }
    }
    
    init() {
        fetch()
    }
    
    
    func getRates() async throws {
        guard let url = URL(string: "https://v6.exchangerate-api.com/v6/851fc5a387b810f9a338b28alatest/\(savedCode)") else { return }
        let (data, _) = try await URLSession.shared.data(from: url)
        let responce = try JSONDecoder().decode(CurencyListResponceSuccess.self, from: data)
        DispatchQueue.main.async {
            self.conversionRates = responce.conversionRates
            self.conversionRates.removeValue(forKey: self.savedCode)
            self.warningIsShowed = false
        }
    }
    
    func fetch() {
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

