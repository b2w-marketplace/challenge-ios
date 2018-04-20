//
//  DetailViewController.swift
//  a-lodjinha
//
//  Created by Daniel Rocha on 4/20/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var product: Product?
    
    var presenter : DetailPresenter?
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var oldPrice: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var titleProduct: UILabel!
    @IBOutlet weak var descriptionProduct: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
    
    func initView() {
    
        guard let product = self.product else {
            return
        }
        
        self.title = product.category.description
        
        AlamofireImageNetworking().requestImage(url: product.urlImagem, success: { (image) in
            self.image.image = image
        }) { (error) in
            self.image.image = nil
        }
        
        self.name.text = product.name
        
        let oldPrice = String.init(format: "De %.02f", product.oldPrice)
            .replacingOccurrences(of: ".", with: ",")
        let price = String.init(format: "Por %.02f", product.price)
            .replacingOccurrences(of: ".", with: ",")
        
        self.oldPrice.text = oldPrice
        self.price.text = price
        self.titleProduct.text = product.name
        self.descriptionProduct.attributedText = self.stringFromHtml(string: product.description)
        self.descriptionProduct.font = UIFont(name: "Helvetica Neue", size: 15)
    }

    @IBAction func reserveTapped(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: "Produto reservado", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }

    private func stringFromHtml(string: String) -> NSAttributedString? {
        do {
            let data = string.data(using: String.Encoding.ascii, allowLossyConversion: true)
            if let d = data {
                let str = try NSAttributedString(data: d,
                                                 options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                                                 documentAttributes: nil)
                return str
            }
        } catch {
        }
        return nil
    }
    
}
