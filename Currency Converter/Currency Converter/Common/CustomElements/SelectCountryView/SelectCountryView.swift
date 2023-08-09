//
//  SelectCountryView.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 09.08.2023.
//

import UIKit

class SelectCountryView: UIView {
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var countyContainerView: UIView!
    @IBOutlet weak var flagView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    var isSelected = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    func commonInit(){
        Bundle.main.loadNibNamed("SelectCountryView", owner: self)
        contentView.fixInView(self)
        countryLabel.text = "No Country Selected"
        countryLabel.font = UIFont(name: "Montserrat-SemiBold", size: 17)
        countyContainerView.layer.cornerRadius = 16
        countyContainerView.layer.borderWidth = 1
        countyContainerView.layer.borderColor = UIColor.tabBarUnselected.cgColor
        flagView.image = UIImage(named: "Ellipse")
        currencyLabel.text = "--"
        currencyLabel.font = UIFont(name: "Montserrat-Regular", size: 17)
        currencyLabel.textColor = .tabBarUnselected
    }
    func configure(country: String, currency: String, code: String) {
        isSelected = true
        self.flagView.image = UIImage(named: code)
        self.countryLabel.text = country
        self.currencyLabel.text = currency + " (\(code))"
    }
    
}
