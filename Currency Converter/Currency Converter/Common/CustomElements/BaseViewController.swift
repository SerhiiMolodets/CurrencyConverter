//
//  BaseViewController.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 07.08.2023.
//

import UIKit
import SwiftUI
import Combine
import RxSwift

class BaseViewController: UIViewController, Storyboarded {
    
    // MARK: - Properties
    private var cancellable: AnyCancellable!
    let bag = DisposeBag()
    let model = MyModel()
    
    // MARK: - Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationItem.hidesBackButton = true
        setupDismissKeyboardGesture()
    }
    // MARK: - Flow funcs
    func performSearch(_ searchHandler: @escaping (String) -> ()) {
        self.cancellable = model.$searchText
            .removeDuplicates()
            .sink { searchHandler($0) }
    }
    func setupNavBar(title: String, addAction: @escaping () -> Void, searchHandler: @escaping (String) -> ()) {
        model.title = title
        model.addAction = addAction
        let navBar = ContentView(model: model)
        let hostingController = UIHostingController(rootView:navBar)
        navigationItem.titleView = hostingController.view
        performSearch { searchHandler($0) }
    }
    
    func setupBackNavBar(title: String, backAction: @escaping () -> Void) {
        let navBar = NavigationBarView(title: title, isBackButtonVisible: true, backAction: backAction)
        let hostingController = UIHostingController(rootView:navBar)
        navigationItem.titleView = hostingController.view
    }
    
    
       func setupDismissKeyboardGesture() {
           let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
           view.addGestureRecognizer(dismissKeyboardTap)
       }
       
       @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
           view.endEditing(true)
       }


}


// MARK: - Data adapter from swiftUI
class MyModel: ObservableObject {
    @Published var searchText: String = ""
    var title = ""
    var addAction: (() -> Void)?
}
struct ContentView: View {
    @ObservedObject var model: MyModel
    
    var body: some View {
        SearchNavigationBarView(
            searchText: $model.searchText,
            addAction: model.addAction, tools: [.search, .add],
            title: model.title
        )
    }
    
    
}
