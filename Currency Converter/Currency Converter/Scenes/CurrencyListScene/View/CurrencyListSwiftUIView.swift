//
//  CurrencyListSwiftUIView.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 04.08.2023.
//

import SwiftUI

struct CurrencyListSwiftUIView: View {
    @StateObject var viewModel = CurrencyListViewModel()
    @State private var isSearching = false
    var body: some View {
        VStack {
            SearchNavigationBarView(searchText: $viewModel.searchQuery, title: "Currency List")
            List {
                ForEach(viewModel.filtered.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                    Text("\(key): \(100/value)")
                }
            }
            .listStyle(PlainListStyle())
        }
 
    }
 
    private func getAttributedTitle() -> AttributedString {
        var attributedString = AttributedString("Currency List")
        let font = Font.body
        attributedString.font = font
        return attributedString
    }
}

struct CurrencyListSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListSwiftUIView()
    }
}
