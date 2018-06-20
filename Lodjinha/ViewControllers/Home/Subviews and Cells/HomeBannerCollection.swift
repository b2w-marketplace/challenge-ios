//
//  HomeBannerCollection.swift
//  Lodjinha
//
//  Created by André Assis on 15/06/18.
//  Copyright © 2018 André Assis. All rights reserved.
//

import UIKit

protocol HomeBannerDelegate {
    func selectBanner(_ banner: BannerModel)
}

class HomeBannerCollection: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let bannerCellIdentifier = "bannerCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var delegate: HomeBannerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        pageControl.isUserInteractionEnabled = false
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.5).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 4
    }
    
    var banners: [BannerModel] = [] {
        didSet {
            pageControl.numberOfPages = banners.count
            collectionView.reloadData()
        }
    }
    
    // MARK: - CollectionView
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let banner = banners.itemFor(index: indexPath),
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bannerCellIdentifier, for: indexPath) as? BannerCollectionCell {
            
            cell.setupWith(banner)
            return cell
            
        } else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: bannerCellIdentifier, for: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if let banner = banners.itemFor(index: indexPath) {
            delegate?.selectBanner(banner)
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = collectionView.contentOffset.x / collectionView.bounds.size.width
        pageControl.currentPage = Int(index)
    }

}

class BannerCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: AlamofireImageView!
    
    func setupWith(_ banner: BannerModel) {
        imageView.loadImageFor(url: banner.imgUrl, placeholderImg: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
}
