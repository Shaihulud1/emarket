//
//  DetailViewController.swift
//  emarket
//
//  Created by Илья Дернов on 21.11.2020.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var product: Product? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let imageURL = URL(string: product!.image) else { fatalError("pic error") }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else {
                fatalError("pic error")
            }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.image.image = image
            }
        }
        nameLabel.text = product?.name
        let displayPrice = product != nil ? String(product!.price) : ""
        priceLabel.text = "\(displayPrice) $"
        
    }

    @IBAction func buyPressed(_ sender: Any) {
    }
    
}
