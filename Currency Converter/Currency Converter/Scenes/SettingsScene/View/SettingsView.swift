//
//  SettingsView.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 06.08.2023.
//

import SwiftUI

struct SettingsView: View {
    var code: String
    
    var body: some View {
        VStack {
            NavigationBarView(title: "Settings", isBackButtonVisible: false)
            Button(action: selectedDidTap) {
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
                            Text(CountryManager.shared.findCountry(by: code) ?? "Not found")
                                .font(.custom("Inter-Medium", size: 14))
                                .foregroundColor(Color(uiColor: .tabBarUnselected))
                                .padding(.leading, 8)
                                .padding(.bottom, 8)
                            Spacer()
                        }
                    }
                    Spacer()
                    
                }
                Image(code)
                    .resizable()
                    .frame(width: 44, height: 44, alignment: .center)
                    .padding(.trailing, 8)
            }
            Divider()
                .background(Color(uiColor: .tabBarUnselected))
                .frame(height: 1)
            
            Spacer()
        }
    }
    private func selectedDidTap() {
// this handle i want to delegate to the my coordinator
//        and in coordinator i want to create destination link and new screen
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(code: "UAH")
    }
}
