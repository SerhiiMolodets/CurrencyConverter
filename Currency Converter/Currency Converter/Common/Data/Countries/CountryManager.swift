//
//  CountryManager.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 05.08.2023.
//

import Foundation

final class CountryManager {
    static let shared = CountryManager()
    private init() { self.loadData() }
    
    
    var currencyData: CountryCurrencies = [:]
    
    private func loadData()  {
        if let url = Bundle.main.url(forResource: "CountryCurrencies", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                currencyData = try JSONDecoder().decode(CountryCurrencies.self, from: data)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }
    
     func findCountry(by currencyCode: String) -> String? {
        for (key, value) in currencyData {
            if value.currencyCode == currencyCode {
                return key
            }
        }
        return nil
    }
    func findCurrencyName(for currencyCode: String) -> String? {
        if let currencyAndName = currencyData.first(where: { $0.value.currencyCode == currencyCode }) {
            return currencyAndName.value.currencyName
        }
        return nil
    }
  
}
