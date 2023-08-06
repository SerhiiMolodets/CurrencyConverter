//
//  SelectCurrencyView.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 06.08.2023.
//

import SwiftUI

struct SelectCurrencyView: View {
    var code: String
    var viewModel: SettingsViewModelProtocol
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .navigationBarHidden(true)
    }
}

struct SelectCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCurrencyView(code: "sss", viewModel: SettingsViewModel())
    }
}
