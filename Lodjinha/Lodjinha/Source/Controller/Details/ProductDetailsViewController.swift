//
//  ProductDetailsViewController.swift
//  Lodjinha
//
//  Created by Guilherme Antunes on 11/03/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import UIKit
import AlamofireImage

class ProductDetailsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var newPriceLabel: UILabel!
    @IBOutlet weak var productDetailsTextView: UITextView!
    @IBOutlet weak var detailTitleLabel: UILabel!
    
    // MARK: - Properties
    private var selectedProduct : Product?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadScreen()
        setupBar()
    }
    
    // MARK: - General Methods
    private func setupBar() {
        navigationController?.navigationBar.tintColor = .white
        title = selectedProduct?.name ?? ""
    }
    
    public func setSelectedProduct(_ product : Product?) {
        selectedProduct = product
    }
    private func loadScreen() {
        guard let product = selectedProduct else {
            return
        }
        
        productNameLabel.text = product.name
        newPriceLabel.text = "Por " + String(format: "%.2f", arguments: [product.newPrice])
        productDetailsTextView.attributedText = product.description.htmlToAttributedString()
        detailTitleLabel.text = product.name
        
        setProductImage(withUrlString: product.imageUrl)
        
        let attributedString = NSMutableAttributedString(string: "De: " + String(format: "%.2f", arguments: [product.oldPrice]))
        attributedString.addAttribute(NSAttributedStringKey.baselineOffset, value: 0, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: NSNumber(value: NSUnderlineStyle.styleThick.rawValue), range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedStringKey.strikethroughColor, value: UIColor.lightGray, range: NSMakeRange(0, attributedString.length))
        oldPriceLabel.attributedText = attributedString
    }
    
    private func setProductImage(withUrlString string : String) {
        
        guard let url = URL(string: string) else {
            return
        }
        
        productImageView.af_setImage(withURL: url, progressQueue: .global(), imageTransition: .noTransition, runImageTransitionIfCached: false)
    }
    
    // MARK: - Actions

}
