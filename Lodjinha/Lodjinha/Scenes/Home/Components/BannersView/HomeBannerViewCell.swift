//
//  HomeBannerViewCell.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 27/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import UIKit

class HomeBannerViewCell: UICollectionViewCell {
    
//    var imageDownloader: ImageDownloader!
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        addSubview(imageView)
        addSubview(activityIndicator)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        // Image View
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        // indicator
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func configure(banner: Banner) {
        
//        self.imageDownloader = imageDownloader
//        activityIndicator.startAnimating()
        self.imageView.setImage(fromUrl: banner.imageUrl, withIndicator: activityIndicator, defaultImage: UIImage(named: "downloadImageDefault"))
//        self.imageDownloader.downloadImage(from: banner.imageUrl) { (image, error) in
//            DispatchQueue.main.async {
//                self.activityIndicator.stopAnimating()
//                self.imageView.image = image
//            }
//        }
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

