//
//  ProductCell.swift
//  emarket
//
//  Created by Илья Дернов on 19.11.2020.
//

import UIKit

class ProductCell: UICollectionViewCell {

    var id: Int = 0 {
        didSet {
            buyButton.setTitle(basket.getBtnTitle(id: id), for: .normal)
        }
    }
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var priceLabel: UILabel!
    let basket = Basket()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func awakeAfter()  {
        print(self.id)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        buyButton.setTitle(basket.getBtnTitle(id: self.id), for: .normal)
        image.isUserInteractionEnabled = true
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(self.imageTaped))
        image.addGestureRecognizer(tapImage)
    }
    
    @objc func imageTaped() {
        let rootController = self.window?.rootViewController
        guard let detailVC = rootController?.storyboard?.instantiateViewController(identifier: "DetailViewController") else { fatalError("Error in detail") }
        rootController?.navigationController?.pushViewController(detailVC, animated: true)

    
    }
    
    @IBAction func buyPressed(_ sender: UIButton) {
        if sender.currentTitle == "Buy" {
            _ = basket.add2Basket(id: self.id)
            sender.setTitle("In Cart", for: .normal)
        } else {
            _ = basket.removeFromBasket(id: self.id)
            sender.setTitle("Buy", for: .normal)
        }
    }
    
    func setupCell(product: Product) {
        self.id = product.id
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
