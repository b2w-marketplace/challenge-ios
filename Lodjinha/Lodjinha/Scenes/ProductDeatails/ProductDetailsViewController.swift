//
//  ProductDetailsViewController.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 29/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    convenience init() {
        self.init(nibName: String(describing: ProductDetailsViewController.self), bundle: Bundle.main)
    }

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceContainerView: UIView!
    @IBOutlet weak var fromPriceLabel: UILabel!
    @IBOutlet weak var toPriceLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var reservationButtonContainerView: UIView!
    
    @IBOutlet weak var reservationButton: UIButton!
    
    
    
    var viewModel: ProductDetailsViewModelType!
    var configurator: ProductsDetailsConfiguratorProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(viewController: self)
        configureViews()
    }
    
    func configureViews() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white];
        priceContainerView.layer.borderWidth = 1
        priceContainerView.layer.borderColor = UIColor.lightGray.cgColor
        
        reservationButtonContainerView.layer.borderWidth = 1
        reservationButtonContainerView.layer.borderColor = UIColor.lightGray.cgColor
        
        productNameLabel.text = viewModel.productName()
        if let attribute = viewModel.productPriceBeforeAttributed() {
            fromPriceLabel.attributedText = attribute
        } else {
            fromPriceLabel.text = viewModel.productPriceBefore()
        }
        
        toPriceLabel.text = viewModel.productPriceNow()
        
        descriptionTextView.text = viewModel.productDescription()
        
        productImageView.setImage(fromUrl: viewModel.productImageUrl(), withIndicator: nil)
    }

    @IBAction func reservationAction(_ sender: Any) {
        
    }
    
    
}

extension ProductDetailsViewController: ProductDetailsServicesDelegate {
    func performingReservation(loading: Bool) {
        
    }
    
    func reservationFinished() {
        
    }
    
}
