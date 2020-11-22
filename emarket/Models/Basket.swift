//
//  Basket.swift
//  emarket
//
//  Created by Илья Дернов on 22.11.2020.
//

import Foundation
import RealmSwift

class Basket {
    var basketProducts:[Int] = []
    let realm = try! Realm()
    
    init() {
        let basketItems = realm.objects(BasketRealm.self)
        for bi in basketItems {
            self.basketProducts.append(bi.id)
        }
    }
    
    func getBtnTitle(id: Int) -> String {
        return self.basketProducts.contains(id) ? "In Cart" : "Buy"
    }

    func add2Basket(id: Int) -> Bool {
        if !self.basketProducts.contains(id) {
            self.basketProducts.append(id)
            let basketItem = BasketRealm()
            basketItem.id = id
            try! realm.write {
                realm.add(basketItem)
            }
            return true
        }
        return false
    }
    
    func removeFromBasket(id: Int) -> Bool {
        if self.basketProducts.contains(id) {
            self.basketProducts = self.basketProducts.filter(){$0 != id}
            let deleteBasket = realm.objects(BasketRealm.self).filter("id == %@", id)
            try! realm.write {
                realm.delete(deleteBasket)
            }
            return true
        }
        return false
    }
}
