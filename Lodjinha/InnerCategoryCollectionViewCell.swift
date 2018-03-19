//
//  InnerCategoryCollectionViewCell.swift
//  Lodjinha
//
//  Created by Daniel Novio on 19/03/18.
//  Copyright © 2018 Daniel Novio. All rights reserved.
//

import UIKit

import Alamofire
import AlamofireImage

class InnerCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var thumbnail: UIImageView!
    
    @IBOutlet weak private var descLabel: UILabel!
    
    override var customObject: Any! {
        didSet {
            guard let category = customObject as? Category else {
                return
            }
            
            if let imagePath = category.imageUrl {
                Alamofire.request(imagePath).responseImage(completionHandler: { (imageResponse) in
                    if let downloadedImage = imageResponse.result.value {
                        self.thumbnail.image = downloadedImage
                    }
                })
                
            }
            
            descLabel.text = category.description
        }
    }
    
}
