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
    }
    
    
    @IBAction func cartPressed(_ sender: UIButton) {
    }
    
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
