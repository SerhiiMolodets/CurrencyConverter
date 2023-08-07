//
//  CurrencyListCellView.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 05.08.2023.
//

import SwiftUI

struct CurrencyListCellView: View {
    let code: String
    let currencyName: String
    let selectedCurrency: String
    let value: Double
    var stringValue: String {
        return String(format: "%.2f", value)
    }
    var body: some View {
        VStack {
            HStack {
                Image(code)
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
                    .padding(.leading, 8)
                Text(code)
                    .font(.custom("Inter-Medium", size: 14))
                    .padding(.leading, 3)
                Text(currencyName)
                    .font(.custom("Inter-Medium", size: 14))
                    .padding(.leading, 1)
                    .foregroundColor(Color(uiColor: .tabBarUnselected))
                Spacer()
                HStack(spacing: 0) {
                    Text(getFirstPart())
                        .foregroundColor(.black)
                        .font(.custom("Inter-Medium", size: 14))
                    Text(getLastTwoSymbols())
                        .foregroundColor(Color(uiColor: .tabBarUnselected))
                        .font(.custom("Inter-Medium", size: 14))
                }
                Text(selectedCurrency)
                    .font(.custom("Inter-Medium", size: 14))
                    .padding(.trailing, 8)
            }
            .padding(.top, 8)
            Divider()
                .background(Color(uiColor: .tabBarUnselected))
                .frame(height: 1)
        }
        
        
    }
    private func getFirstPart() -> String {
        guard stringValue.count >= 2 else {
            return stringValue
        }
        return String(stringValue.dropLast(2))
    }
    
    private func getLastTwoSymbols() -> String {
        guard stringValue.count >= 2 else {
            return ""
        }
        return String(stringValue.suffix(2))
    }
    
}

struct CurrencyListCellView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListCellView(code: "UAH", currencyName: "Ukrainian Hryvnia", selectedCurrency: "UAH", value: 3600.00)
    }
}
