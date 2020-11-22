//
//  BasketViewController.swift
//  emarket
//
//  Created by Илья Дернов on 22.11.2020.
//

import UIKit
import Firebase


class BasketViewController: UIViewController {

    let db = Firestore.firestore()
    var products = [Product]()
    let basket = Basket()
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "BasketCell", bundle: nil), forCellWithReuseIdentifier: "BasketCell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        loadBasket()
    }
    
    func loadBasket() {
        let basketIds = basket.getBasketIds()
        db.collection("products").whereField("id", in: basketIds)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        if data["id"] != nil && data["name"] != nil && data["price"] != nil && data["image"] != nil {
                            let id = data["id"] as! Int
                            let name = data["name"] as! String
                            let price = (data["price"] as? NSNumber)?.floatValue ?? 0
                            let image = data["image"] as! String
                            let prod = Product(id: id, image: image, name: name, price: price)
                            self.products.append(prod)
                            DispatchQueue.main.async {
                                self.collectionView.reloadData()
                            }
                        }
                    }
                }
            }
    }

}

//MARK - CollectionView

extension BasketViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasketCell", for: indexPath) as! BasketCell
        let cellProduct = products[indexPath.item]
        cell.setupCell(product: cellProduct)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = CGFloat(Constants.cellHeight)
        return CGSize(width: UIScreen.main.bounds.width, height: height)
    }
    
    
}
