//
//  ProductDetailVC.swift
//  B2W
//
//  Created by Nicholas Matos on 2/7/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit
import SDWebImage

protocol ProductDetailDelegate {
    func didLoad()
    func bookAction()
}

class ProductDetailVC: UIViewController {
    var delegate: ProductDetailDelegate?
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDiscouted: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate?.didLoad()
        bookButton.layer.masksToBounds = true
        bookButton.layer.cornerRadius = 5
        
        bookButton.backgroundColor = UIColor.init(netHex: kAppColor)
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    func bind(product: Product?){
        if let stringUrl = product?.urlImagem{
            if let url = URL(string: stringUrl){
                productImage.sd_setImage(with: url, completed: nil)
            }
        }
        
        productTitle.text = product?.getProductDescriptionString()
        productPrice.text = product?.price
        productDiscouted.text = product?.discoutedPrice
        productDescription.text = product?.productDescription?.htmlToString
    }
    
    @IBAction func bookAction(_ sender: Any) {
        delegate?.bookAction()
    }
}
