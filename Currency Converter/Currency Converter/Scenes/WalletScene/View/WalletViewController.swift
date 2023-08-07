//
//  WalletViewController.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 04.08.2023.
//

import UIKit

class WalletViewController: BaseViewController, Storyboarded {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar(title: "Wallet") {
            print("add tapped")
        } searchHandler: { searchtext in
            print(searchtext)
        }

    }

}
