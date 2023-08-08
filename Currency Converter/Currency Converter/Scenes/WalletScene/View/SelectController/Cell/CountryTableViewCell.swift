//
//  CountryTableViewCell.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 07.08.2023.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    @IBOutlet weak var flagView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    private func configureUI() {
        countryLabel.font = UIFont(name: "Montserrat-SemiBold", size: 17)
        currencyLabel.font = UIFont(name: "Montserrat-Regular", size: 17)
        currencyLabel.textColor = .tabBarUnselected
    }
    
    func configure(code: String, country: String, currency: String) {
        flagView.image = UIImage(named: code)
        countryLabel.text = country
        currencyLabel.text = currency + " (\(code))"
    }
    
}
