//
//  CategoryCollectionViewCell.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 13/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell
{
    // MARK: - Var
    var category: Category?
    {
        didSet
        {
            if let category = category
            {
                setTitle(title: category.strDescription)
                setImage(imgURL: category.image.urlImage)
            }
        }
    }
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryTitleLabel: UILabel!

    
    private func setTitle(title: String)
    {
        categoryTitleLabel.text = title
    }
    
    private func setImage(imgURL: String)
    {
        categoryImage.download(image: imgURL)
    }
}
