//
//  RealmManager.swift
//  Currency Converter
//
//  Created by Serhii Molodets on 08.08.2023.
//

import Foundation
import RealmSwift

class RealmManager: RealmManagerProtocol {
    
    func saveWalletModels(walletModels: WalletModel) {
        DispatchQueue.main.async {
            let realm = try! Realm()
            try! realm.write {
                realm.add(walletModels, update: .modified)
            }
        }

    }
    
    func loadWalletModels(completion: @escaping([WalletModel]) -> Void) {
        DispatchQueue.main.async {
            let realm = try! Realm()
            completion(Array(realm.objects(WalletModel.self)))
        }
    }
    
    func cleanAll() {
        DispatchQueue.main.async {
            do {
                   let realm = try Realm()
                   try realm.write {
                       realm.deleteAll()
                   }
               } catch let error {
                   print("Error deleting all wallet models: \(error)")
               }
        }
    }
}
