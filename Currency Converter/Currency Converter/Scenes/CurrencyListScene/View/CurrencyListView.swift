//
//  CurrencyListSwiftUIView.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 04.08.2023.
//

import SwiftUI

struct CurrencyListView: View {
    @EnvironmentObject var viewModel: CurrencyListViewModel
    @State private var isSearching = false
    var body: some View {
        VStack {
            SearchNavigationBarView(searchText: $viewModel.searchQuery, title: "Currency List")
                .navigationBarHidden(true)
            if viewModel.warningIsShowed {
                Spacer()
                ErrorView { Task {
                    viewModel.fetch()          }
                }
                Spacer()
            } else {
                List {
                    Section(header: EmptyView()) {
                        ForEach(Array(viewModel.filtered.sorted(by: { $0.key < $1.key })), id: \.key) { key, value in
                            if let currencyName = CountryManager.shared.findCurrencyName(for: key) {
                                CurrencyListCellView(code: key, currencyName: currencyName, selectedCurrency: viewModel.savedCode, value: (100/value))
                                    .id(UUID().uuidString)
                                    .listRowSeparator(.hidden)
                                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            }
                        }
                    }
                    
                }
                .onAppear {
                    viewModel.fetch()
                }
                .listRowBackground(Color.clear)
                .listStyle(PlainListStyle())
            }
        }
        
    }
    
    private func getAttributedTitle() -> AttributedString {
        var attributedString = AttributedString("Currency List")
        let font = Font.body
        attributedString.font = font
        return attributedString
    }
}

struct CurrencyListView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListView().environmentObject(CurrencyListViewModel())
    }
}
