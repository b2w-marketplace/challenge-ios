//
//  DetailViewController.swift
//  Challenge-ios
//
//  Created by Roberto Luiz Veiga Junior on 16/02/17.
//  Copyright © 2017 MyOrganization. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

	@IBOutlet weak var imgProduct: UIImageView!
	@IBOutlet weak var lbName: UILabel!
	@IBOutlet weak var lbPriceFrom: UILabel!
	@IBOutlet weak var lbPrice: UILabel!
	@IBOutlet weak var lbTitle: UILabel!
	@IBOutlet weak var txtDescription: UITextView!
	@IBOutlet weak var btPreOrder: UIButton!

	var product: Product!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initCommon()
    }
    
    func initCommon() {
        self.setFields()
        self.customButton()
        self.loadImage()
    }

	fileprivate func customButton() {
		self.btPreOrder.layer.cornerRadius = 5
		self.btPreOrder.layer.masksToBounds = true
	}

	fileprivate func setFields() {
        self.title = self.product.category.description
		self.lbName.text = self.product.name
		self.lbPriceFrom.text = "De: " + String(self.product.priceFrom)
        let line = UIView(frame: CGRect(x: 0, y: self.lbPriceFrom.frame.height/2, width: self.lbPriceFrom.frame.width, height: 1))
        line.backgroundColor = UIColor.lightGray
        self.lbPriceFrom.addSubview(line)
		self.lbPrice.text = "Por: " + String(self.product.price)
        self.lbTitle.text = "Descrição"
        self.txtDescription.text = self.stringToUnicodeString(HTMLtoString: self.product.description)
	}
    
    func stringToUnicodeString(HTMLtoString string: String) -> String {
        var finalString = String()
        if let htmldata = string.data(using: String.Encoding.unicode), let attributedString = try? NSAttributedString(data: htmldata, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil) {
            finalString = attributedString.string
        }
        return finalString
    }

	fileprivate func loadImage() {
		if let image = product.image {
			DispatchQueue.main.async(execute: {
				Category.downloadImage(url: image) { (image) in
					self.imgProduct.image = image
				}
			})
		}
	}

	@IBAction func preOrder(_ sender: UIButton) {
        Product().preOrder(productId: self.product.id) { (success) in
            var alert = UIAlertController(title: "", message: "Produto reservado com sucesso", preferredStyle: .alert)
            if !success {
                alert = UIAlertController(title: "", message: "Não foi possível reservar o produto", preferredStyle: .alert)
            }
            let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.navigationController!.popViewController(animated: true)
            })
            alert.addAction(action)
            self.present(alert, animated: true)
            
        }
	}
}
