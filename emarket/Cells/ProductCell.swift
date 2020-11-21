//
//  ProductCell.swift
//  emarket
//
//  Created by Илья Дернов on 19.11.2020.
//

import UIKit

class ProductCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        image.isUserInteractionEnabled = true
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(self.imageTaped))
        image.addGestureRecognizer(tapImage)
    }
    
    @objc func imageTaped() {
        let rootController = self.window?.rootViewController
        guard let detailVC = rootController?.storyboard?.instantiateViewController(identifier: "DetailViewController") else { fatalError("Error in detail") }
        rootController?.navigationController?.pushViewController(detailVC, animated: true)
        print("tt")
//        let targetVC = DetailViewController()
//        let navVC = UINavigationController(rootViewController: targetVC)
//        self.window?.rootViewController?.present(navVC, animated: true)
    
    }
    
//
//    @IBAction func cartPressed(_ sender: UIButton) {
//    }
    
    func setupCell(product: Product) {
        productLabel.text = product.name
        priceLabel.text = "\(product.price) $"
        
        
        guard let imageURL = URL(string: product.image) else { fatalError("pic error") }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else {
                let newImageData = Data(base64Encoded: product.image)
                if let newImageData = newImageData {
                    self.image.image = UIImage(data: newImageData)
                }
                return
            }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.image.image = image
            }
        }
    }

}
