//
//  SerachNavigationBarView.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 05.08.2023.
//

import SwiftUI

struct SearchNavigationBarView: View {
    @Binding var searchText: String
    @State private var isSearching = false
    var title: String
    var body: some View {
        VStack {
            HStack {
                Spacer()
                if isSearching {
                    TextField("Search", text: $searchText, onEditingChanged: { isEditing in
                        isSearching = isEditing
                    })
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                } else {
                    Text(title)
                        .font(Font.custom("Montserrat", size: 17))
                        .fontWeight(.semibold)
                }
                Spacer()
                Button(action: {
                    isSearching.toggle()
                    searchText = ""
                }) {
                    Image(systemName: isSearching ? "xmark.circle.fill" : "magnifyingglass")
                        .foregroundColor(Color(uiColor: .tabBarUnselected))
                }
                .padding(.trailing, 8)
            }
            .padding(.bottom, 3)
            Divider()
                .background(Color(uiColor: .tabBarUnselected))
                .frame(height: 1)
        }
    }
    
    
}


struct SerachNavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchNavigationBarView(searchText: .constant(""), title: "test string")
    }
}
