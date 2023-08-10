//
//  SelectCurrencyCell.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 06.08.2023.
//

import SwiftUI

struct SelectCurrencyCell: View {
    
    // MARK: - Properties
    let code: String
    let currencyName: String
    var isSelected: Bool
    
    // MARK: - Content
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
                Image(isSelected ? "radio-checked" : "radio-unchecked")
                    .resizable()
                    .frame(width: 32, height: 32, alignment: .center)
                    .padding(.trailing, 8)
             
            }
            .padding(.top, 8)
            Divider()
                .background(Color(uiColor: .tabBarUnselected))
                .frame(height: 1)
        }
    }
}

// MARK: - Preview
struct SelectCurrencyCell_Previews: PreviewProvider {
    static var previews: some View {
        SelectCurrencyCell(code: "USD", currencyName: "US Dollars", isSelected: true)
    }
}
