//
//  String+ChangeLast3SymbColor.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 08.08.2023.
//

import Foundation
import UIKit

extension String {
    func createAttributedText() -> NSAttributedString {

        let attributedString = NSMutableAttributedString(string: self)
        
        if self.count >= 3 {
            let lastThreeRange = NSRange(location: self.count - 3, length: 3)
            attributedString.addAttribute(.foregroundColor, value: UIColor.tabBarUnselected, range: lastThreeRange)
        }
        
        return attributedString
    }
}
