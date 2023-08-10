//
//  SettingsView.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 06.08.2023.
//

import SwiftUI
import RxCocoa
import RxSwift

struct SettingsView: View {
    
    // MARK: - Properties
    var viewModel: SettingsViewModelProtocol
    @State private var savedCode: String = "UAH"
    
    // MARK: - Content
    var body: some View {
        VStack {
            NavigationBarView(title: "Settings", isBackButtonVisible: false)
                .navigationBarHidden(true)
            Button(action: {
                viewModel.selectedCurrencySubject.onNext(())
            })
            {
                HStack {
                    VStack {
                        HStack {
                            Text("Selected Currency:")
                                .font(.custom("Inter-Medium", size: 14))
                                .foregroundColor(.black)
                                .padding(.leading, 8)
                                .padding(.top, 8)
                                .padding(.bottom, 4)
                            Spacer()
                        }
                        HStack {
                            Text(CountryManager.shared.findCountry(by: savedCode) ?? "Not found")
                                .font(.custom("Inter-Medium", size: 14))
                                .foregroundColor(Color(uiColor: .tabBarUnselected))
                                .padding(.leading, 8)
                                .padding(.bottom, 8)
                            Spacer()
                        }
                    }
                    Spacer()
                    
                }
                Image(savedCode)
                    .resizable()
                    .frame(width: 44, height: 44, alignment: .center)
                    .padding(.trailing, 8)
            }
            .onAppear {
                viewModel.loadSelectedCurrency()
                savedCode = viewModel.savedCode
            }
            Divider()
                .background(Color(uiColor: .tabBarUnselected))
                .frame(height: 1)
            
            Spacer()
        }
    }
}

// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: SettingsViewModel())
    }
}
