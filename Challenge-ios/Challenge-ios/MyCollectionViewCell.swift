//
//  MyCollectionViewCell.swift
//  Challenge-ios
//
//  Created by Roberto Luiz Veiga Junior on 14/02/17.
//  Copyright © 2017 MyOrganization. All rights reserved.
//

import UIKit

class MyCollectionViewCell : UICollectionViewCell {

    @IBOutlet weak var acLoading: UIActivityIndicatorView!
    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    
    func load(category: Category) {
        if let description = category.description {
            self.lbTitle.text = description
        }
        if let image = category.image {
            DispatchQueue.main.async(execute: {
            Category.downloadImage(url: image) { (image) in
                    self.imgCategory?.image = image
                    self.acLoading.stopAnimating()
            }
        })
        }
    }
}

