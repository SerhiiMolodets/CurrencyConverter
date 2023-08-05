//
//  CurrencyListViewModel.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 05.08.2023.
//

import SwiftUI


class CurrencyListViewModel: CurrencyListViewModelProtocol, ObservableObject {
    @Published var conversionRates: [String: Double] = [:]
    @Published var searchQuery: String = ""
    @Published var error: Error?
    var filtered: [String: Double] {
        guard !searchQuery.isEmpty else { return conversionRates }
        
        return conversionRates.filter { currency in
            currency.key.lowercased().contains(searchQuery.lowercased())
        }
    }
    
    init() {
        Task {
            do {
                try await getRates()
            } catch {
                print(error)
            }
        }
    }
    
    
    func getRates() async throws {
        guard let url = URL(string: "https://v6.exchangerate-api.com/v6/851fc5a387b810f9a338b28alatest/UAH") else { return }
        let (data, _) = try await URLSession.shared.data(from: url)
        let responce = try JSONDecoder().decode(CurencyListResponceSuccess.self, from: data)
        DispatchQueue.main.async {
            self.conversionRates = responce.conversionRates
        }
    }
    
}

