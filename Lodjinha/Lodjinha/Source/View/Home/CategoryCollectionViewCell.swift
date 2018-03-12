//
//  CategoryCollectionViewCell.swift
//  Lodjinha
//
//  Created by Guilherme Antunes on 10/03/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell, Identifiable {
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    public func initWithModel(_ model : Category) {
        categoryNameLabel.text = model.description
        setCategoryImage(withUrlString: model.imageUrl)
    }
    
    private func setCategoryImage(withUrlString string : String) {
        
        guard let url = URL(string: string) else {
            print("Failed to get url!")
            return
        }
        
        categoryImageView.af_setImage(withURL: url, progressQueue: .global(), imageTransition: .flipFromLeft(0.5), runImageTransitionIfCached: false)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryImageView.af_cancelImageRequest()
        categoryImageView.image = UIImage()
        categoryNameLabel.text = ""
    }
}
