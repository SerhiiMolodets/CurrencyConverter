//
//  Storyboarded.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 04.08.2023.
//

import UIKit

protocol Storyboarded: AnyObject {

    static func instantiate(coordinator: Coordinator, bundle: Bundle?) -> Self
}

extension Storyboarded where Self: UIViewController {

    static func instantiate(coordinator: Coordinator, bundle: Bundle? = nil) -> Self {
        let board = UIStoryboard(name: String(describing: self), bundle: bundle)
        let vc = board.instantiateInitialViewController()
        let controller = vc as! Self
        return controller
    }
}
