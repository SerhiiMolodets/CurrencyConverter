//
//  WalletTableViewCell.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 07.08.2023.
//

import UIKit

class WalletTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var currencyCodeLabel: UILabel!
    @IBOutlet weak var usdAmountLabel: UILabel!
    @IBOutlet weak var currencyAmountLabel: UILabel!
    
    // MARK: - Lifecycle funcs
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    // MARK: - Flow funcs
    private func configureUI () {
        currencyCodeLabel.font = UIFont(name: "Inter-Medium", size: 24)
        usdAmountLabel.textColor = .tabBarUnselected
        usdAmountLabel.font = UIFont(name: "Inter-Medium", size: 16)
        currencyAmountLabel.font = UIFont(name: "Inter-Medium", size: 24)
    }
    func configure(_ data: WalletModel) {
        flagImageView.image = UIImage(named: data.code)
        currencyCodeLabel.text = data.code.uppercased()
        currencyAmountLabel.attributedText = (data.code.getSymbolForCurrencyCode() + data.stringAmount).createAttributedText()
        usdAmountLabel.text = "USD".getSymbolForCurrencyCode() + String(format: "%.2f", data.usdAmmount)
    }
    
}
