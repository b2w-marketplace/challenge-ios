//
//  HomeBannerViewCell.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 27/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import UIKit

protocol ImageDownloader {
    func downloadImage(from url: String, completion: @escaping (UIImage?,Error?) -> Void)
}

class BannerImageDownloader: ImageDownloader {
    func downloadImage(from url: String, completion: @escaping (UIImage?, Error?) -> Void) {
        guard let url = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                completion(nil, error)
                return
            }
            
            guard let imageData = data else {
                completion(nil, error)
                return
            }
            
            completion(UIImage(data: imageData), nil)
            
        }.resume()
    }
}

struct Banner {
    let imageUrl: String
}

class HomeBannerViewCell: UICollectionViewCell {
    
    var imageDownloader: ImageDownloader!
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
    
    func configure(imageDownloader: ImageDownloader, banner: Banner) {
        
        self.imageDownloader = imageDownloader
        activityIndicator.startAnimating()
        self.imageDownloader.downloadImage(from: banner.imageUrl) { (image, error) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.imageView.image = image
            }
        }
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

