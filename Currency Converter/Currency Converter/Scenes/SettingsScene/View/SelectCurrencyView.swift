//
//  SelectCurrencyView.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 06.08.2023.
//

import SwiftUI

struct SelectCurrencyView: View {
    
    // MARK: - Properties
    var viewModel: SettingsViewModelProtocol
    @Environment(\.presentationMode) var presentationMode
    // MARK: - Content view
    var body: some View {
        VStack {
                NavigationBarView(title: "Selected Currency", isBackButtonVisible: true)
                            .navigationBarHidden(true)
            List(viewModel.listData, id: \.self) { item in
                SelectCurrencyCell(code: item.currencyCode, currencyName: item.currencyName, isSelected: viewModel.isSelected(item.currencyCode))
                    .onTapGesture {
                        viewModel.saveSelected(currency: item.currencyCode)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .listStyle(PlainListStyle())
        }


    }
}

// MARK: - Content preview
struct SelectCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCurrencyView(viewModel: SettingsViewModel())
    }
}
