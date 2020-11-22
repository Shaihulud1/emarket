//
//  BasketCell.swift
//  emarket
//
//  Created by Илья Дернов on 22.11.2020.
//

import UIKit

class BasketCell: UICollectionViewCell {

    var id: Int = 0
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(product: Product) {
        self.id = product.id
        nameLabel.text = product.name
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
