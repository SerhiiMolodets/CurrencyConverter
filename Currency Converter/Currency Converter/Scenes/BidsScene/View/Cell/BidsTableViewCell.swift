//
//  BidsTableViewCell.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 08.08.2023.
//

import UIKit

class BidsTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var fromFlagView: UIImageView!
    @IBOutlet weak var toFlagView: UIImageView!
    @IBOutlet weak var currenciesLabel: UILabel!
    @IBOutlet weak var fromAmountLabel: UILabel!
    @IBOutlet weak var toAmountLabel: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    
    // MARK: - Flow funcs
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    private func configureUI() {
        currenciesLabel.font = UIFont(name: "Inter-Medium", size: 15)
        fromAmountLabel.font = UIFont(name: "Inter-SemiBold", size: 20)
        toAmountLabel.font = UIFont(name: "Inter-SemiBold", size: 20)
        statusButton.layer.cornerRadius = 8
        statusButton.backgroundColor = .statusGreen
        statusButton.tintColor = .tintGreen
    }
    func configure(_ model: BidModel) {
        fromFlagView.image = UIImage(named: model.fromCode)
        toFlagView.image = UIImage(named: model.toCode)
        let currencyText = model.fromCode + "/" + model.toCode
        currenciesLabel.attributedText = changeSlashColor(currencyText)
        fromAmountLabel.attributedText = (model.fromCode.getSymbolForCurrencyCode() + model.stringFromAmount).createAttributedText()
        toAmountLabel.attributedText = (model.toCode.getSymbolForCurrencyCode() + model.stringToAmount).createAttributedText()
        switch model.isOpen {
        case true: openStatus()
        case false: closedStatus()
        }
    }
    
    private func changeSlashColor(_ text: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        let slashRange = (attributedString.string as NSString).range(of: "/")
        attributedString.addAttribute(.foregroundColor, value: UIColor.tabBarUnselected, range: slashRange)
        return attributedString
    }
    private func openStatus() {
        statusButton.backgroundColor = .statusGreen
        statusButton.tintColor = .tintGreen
        statusButton.setTitle("Open", for: .normal)
    }
    private func closedStatus() {
        statusButton.backgroundColor = .statusGray
        statusButton.tintColor = .tabBarUnselected
        statusButton.setTitle("Closed", for: .normal)
    }
    
}
