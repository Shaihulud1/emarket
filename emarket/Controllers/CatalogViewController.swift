//
//  MenuViewController.swift
//  emarket
//
//  Created by Илья Дернов on 19.11.2020.
//

import UIKit

class CatalogViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var products = [Product]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        loadCatalog()
    }
    
    
    func loadCatalog()  {
        self.products = [
            Product(id: 1, image: "https://pics.vitaexpress.ru/public/images/large_w/176826.jpg", name:"Product 1 ", price: 5.34),
            Product(id: 2, image: "https://pics.vitaexpress.ru/public/images/large_w/176826.jpg", name:"Product 2", price: 99.99),
            Product(id: 3, image: "https://pics.vitaexpress.ru/public/images/large_w/176826.jpg", name:"Product 3", price: 15.50),
        ]
        DispatchQueue.main.async {
            self.collectionView.reloadData()
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
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//    //        let searchText = searchBar.text
//    //        let request: NSFetchRequest<Item> = Item.fetchRequest()
//    //        if (searchText != "") {
//    //            request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText!)
//    //            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//    //        }
//    //        loadItems(request: request)
//    }
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
//        var predicate : NSPredicate? = nil
//        if  searchText != "" {
//            predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
//            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        }
//        loadItems(request: request, predicate: predicate)
    }
}
