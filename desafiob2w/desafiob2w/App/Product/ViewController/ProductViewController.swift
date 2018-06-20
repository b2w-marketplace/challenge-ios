//
//  ProductViewController.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 19/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceFromLabel: UILabel!
    @IBOutlet weak var productPriceToLabel: UILabel!
    @IBOutlet weak var productDescriptionTextView: UITextView!
    @IBOutlet weak var secondProductTitleLabel: UILabel!
    @IBOutlet weak var reserveButton: UIButton!
    
    
    private var productId: Int!
    
    private lazy var presenter = ProductPresenterFactory.make(delegate: self)
    
    override func viewWillAppear(_ animated: Bool) {
        assertDependencies()
        presenter.getProduct(productId: productId)
        view.setupPresentation(parentView: view)
        reserveButton.setRound(true)
    }
    
    @IBAction func reserveButtonAction(_ sender: UIButton) {
        presenter.setReserveProduct()
    }
    
}

extension ProductViewController: ProductPresentation {
    func onLoading() {
        view.presentLoading()
    }
    
    func offLoading() {
        view.dismissLoading()
    }
    
    func onError(error: NetworkError) {
        view.presentError(error: error)
    }
    
    func onProduct(product: ProductViewModel) {
        productImageView.kf.setImage(with: product.urlImage)
        productTitleLabel.text = product.name
        productPriceFromLabel.attributedText = product.priceFrom
        productPriceToLabel.text = product.priceTo
        productDescriptionTextView.attributedText = product.description.htmlAttributed(family: nil, size: 14)
        secondProductTitleLabel.text = product.name
        title = product.categoryName
    }
    
    func onReserved(message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}



extension ProductViewController: Injectable {
    func inject(_ productId: Int) {
        self.productId = productId
    }
    
    func assertDependencies() {
        assert(productId != nil)
    }
}
