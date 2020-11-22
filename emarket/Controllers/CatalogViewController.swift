//
//  MenuViewController.swift
//  emarket
//
//  Created by Илья Дернов on 19.11.2020.
//

import UIKit
import Firebase

class CatalogViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var products = [Product]()
    let db = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.searchBar.delegate = self
        
        loadCatalog()
    }
    
    
    func loadCatalog(search:String? = nil)  {
        db.collection("products").getDocuments() { (querySnapshot, err) in
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
                        if (search != nil) {
                            let res = self.products.filter { $0.name.contains(search!) }
                            self.products = res
                        }
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

extension CatalogViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let cellProduct = products[indexPath.item]
        cell.setupCell(product: cellProduct)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = CGFloat(Constants.cellHeight)
        return CGSize(width: UIScreen.main.bounds.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newVC = storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailViewController 
        let indexNum = indexPath[1]
        newVC.product = self.products[indexNum]
        navigationController?.pushViewController(newVC, animated: true)
    }
}

//MARK - searchBar

extension CatalogViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText = searchBar.text == "" ? nil : searchBar.text
        loadCatalog(search: searchText)
    }
        
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText != "" {
//            let res = products.filter { $0.name.contains(searchText) }
//            self.products = res
//        } else {
//            loadCatalog()
//        }
//
//    }
}
