//
//  ErrorView.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 05.08.2023.
//

import SwiftUI

struct ErrorView: View {
    
    // MARK: - Properties
    var action: () -> Void
    
    // MARK: - Content
    var body: some View {
        VStack {
            Image("warning")
                .padding(.bottom, 23)
            Text("Something went wrong while fetching data. Please, try again")
                .font(.custom("Montserrat", size: 20))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 43)
                .padding(.bottom, 37)
            Button("Retry") {
                action()
            }
            .frame(width: 200, height: 42, alignment: .center)
            .foregroundColor(.white)
            .background(Color(uiColor: .retryButton))
            .cornerRadius(8)
        }
    }
}

// MARK: - Preview
struct ErrorView_Previews: PreviewProvider {
    static var previews: some View { ErrorView {} }
}
