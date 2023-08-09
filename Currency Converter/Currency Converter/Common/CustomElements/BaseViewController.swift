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
    
    private var cancellable: AnyCancellable!
    let bag = DisposeBag()
    let model = MyModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationItem.hidesBackButton = true
    }
    
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

}


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
