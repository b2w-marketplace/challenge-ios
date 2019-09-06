//
//  BannerTableViewCell.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 05/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit

class BannerTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
