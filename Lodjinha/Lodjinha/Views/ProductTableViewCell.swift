//
//  ProductTableViewCell.swift
//  Lodjinha
//
//  Created by Lucas Gonçalves Serrano on 10/01/19.
//  Copyright © 2019 Lucas Gonçalves Serrano. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var productImage: CachedImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var beforePrice: UILabel!
    @IBOutlet weak var afterPrice: UILabel!
    @IBOutlet var indicatorView: UIActivityIndicatorView!

    override func prepareForReuse() {
        super.prepareForReuse()

        configure(with: nil)
    }

    private func setupViews() {
        titleLabel.font = Font(.installed(.RobotoBold), size: .standard(.title)).instance
        titleLabel.textColor = .GreyishBrown

        beforePrice.font = Font(.installed(.RobotoMedium), size: .standard(.subtitle)).instance
        beforePrice.textColor = .Greyish

        afterPrice.font = Font(.installed(.RobotoBold), size: .standard(.title)).instance
        afterPrice.textColor = .Tomato

    }

    override func awakeFromNib() {
        super.awakeFromNib()

        indicatorView.hidesWhenStopped = true
        indicatorView.color = .WarmPurple

        setupViews()
    }

    func configure(with product: Product?) {
        if let product = product {
            titleLabel?.text = product.name
            let attributeString = NSMutableAttributedString(string: String(format: "De: %.2f", product.priceBefore))
            attributeString.addAttribute(.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
            beforePrice?.attributedText = attributeString
            afterPrice?.text = String(format: "Por %.2f", product.priceAfter)
            titleLabel.alpha = 1
            beforePrice.alpha = 1
            afterPrice.alpha = 1
            productImage.loadImageFromURL(imageUrl: product.imageUrl)
            accessoryType = .disclosureIndicator
            indicatorView.stopAnimating()
        } else {
            titleLabel.alpha = 0
            beforePrice.alpha = 0
            afterPrice.alpha = 0
            productImage.image = nil
            accessoryType = .none
            indicatorView.startAnimating()
        }
    }
}
