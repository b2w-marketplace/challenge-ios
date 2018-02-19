//
//  BannerCollectionViewCell.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 13/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell
{
    // MARK: - Var
    var banner: Banner?
    {
        didSet
        {
            if let banner = banner
            {
                setImage(imgURL: banner.image.urlImage)
            }
        }
    }
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var bannerImage: UIImageView!
    
    
    private func setImage(imgURL: String)
    {
        bannerImage.download(image: imgURL)
    }
}
