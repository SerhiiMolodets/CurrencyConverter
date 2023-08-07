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
    
    var addAction: (() -> Void)?
    var tools: [Tool]
    var title: String
    var body: some View {
        VStack {
            ZStack {
                Spacer()
                if isSearching {
                    HStack {
                        TextField("Search", text: $searchText, onEditingChanged: { isEditing in
                            isSearching = isEditing
                        })
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color(.systemGray6))
                    .cornerRadius(10)
                    }
                    .padding(.horizontal, 8)
                    .padding(.trailing, 24)
                } else {
                    Text(title)
                        .font(Font.custom("Montserrat", size: 17))
                        .fontWeight(.semibold)
                }
                HStack {
                    Spacer()
                    ForEach(tools, id: \.self) { tool in
                        switch tool {
                        case .search:
                            Button(action: {
                                withAnimation {
                                    isSearching.toggle()
                                }
                                searchText = ""
                            }) {
                                Image(systemName: isSearching ? "xmark.circle.fill" : "magnifyingglass")
                                    .foregroundColor(Color(uiColor: .tabBarUnselected))
                            }
                            .padding(.trailing, 8)
                        case .add:
                            Button(action: {
                                addAction?()
                            }) {
                                Image(systemName: "plus")
                                    .foregroundColor(Color(uiColor: .tabBarUnselected))
                            }
                            .padding(.trailing, 8)
                        }
                    }

                }
  
            }
            .padding(.bottom, 3)
            Divider()
                .background(Color(uiColor: .tabBarUnselected))
                .frame(height: 1)
        }
    }
    enum Tool {
        case search, add
    }
      
}


struct SerachNavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchNavigationBarView(searchText: .constant(""), addAction: { }, tools: [.search, .add], title: "Test title")
    }
}
