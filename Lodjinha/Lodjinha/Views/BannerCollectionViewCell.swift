//
//  BannerCollectionViewCell.swift
//  Lodjinha
//
//  Created by Lucas Gonçalves Serrano on 11/01/19.
//  Copyright © 2019 Lucas Gonçalves Serrano. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    let imageView: CachedImageView = {
        let imageView = CachedImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func prepareForReuse() {
        super.prepareForReuse()

        configure(with: nil)
    }

    override func awakeFromNib() {
        setupLayout()
    }

    func configure(with banner: BannerItem?) {
        if let url = banner?.imageUrl {
            imageView.loadImageFromURL(imageUrl: url, defaultImage: #imageLiteral(resourceName: "placeholder-wide"))
        } else {
            imageView.image = nil
        }
    }

    private func setupLayout() {
        addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }

}
