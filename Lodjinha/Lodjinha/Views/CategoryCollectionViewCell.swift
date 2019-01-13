//
//  CategoryCollectionViewCell.swift
//  Lodjinha
//
//  Created by Lucas Gonçalves Serrano on 12/01/19.
//  Copyright © 2019 Lucas Gonçalves Serrano. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: CachedImageView!
    @IBOutlet weak var categoryName: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()

        configure(with: nil)
    }

    private func setupViews() {
        categoryName.font = Font(.installed(.RobotoRegular), size: .standard(.category)).instance
        categoryName.textColor = .GreyishBrown
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        setupViews()
    }

    func configure(with category: Category?) {
        if let category = category {
            categoryName?.text = category.description
            categoryName.alpha = 1
            imageView.loadImageFromURL(imageUrl: category.imageUrl, defaultImage: #imageLiteral(resourceName: "placeholder"))
        } else {
            categoryName.alpha = 0
            imageView.image = nil
        }
    }
}
