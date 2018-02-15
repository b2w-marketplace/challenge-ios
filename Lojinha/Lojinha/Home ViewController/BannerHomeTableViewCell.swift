//
//  BannerHomeTableViewCell.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 13/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import UIKit

class BannerHomeTableViewCell: UITableViewCell
{
    // MARK: - IBOutlets
    @IBOutlet weak var bannerHomeCollectionView: UICollectionView!
    @IBOutlet weak var bannerHomePageControl: UIPageControl!
    
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)


    }

}


extension BannerHomeTableViewCell
{
    func setCollectionViewDataSourceDelegate<deleg: UICollectionViewDataSource & UICollectionViewDelegate> (dataSourceDelegate: deleg, forRow row: Int)
    {
        bannerHomeCollectionView.dataSource = dataSourceDelegate
        bannerHomeCollectionView.delegate = dataSourceDelegate
        bannerHomeCollectionView.tag = row
        bannerHomeCollectionView.setContentOffset(bannerHomeCollectionView.contentOffset, animated: false)
        bannerHomeCollectionView.reloadData()
    }
    
    var collectionViewOffSet: CGFloat
    {
        set
        {
            bannerHomeCollectionView.contentOffset.x = newValue
        }
        get
        {
            return bannerHomeCollectionView.contentOffset.x
        }
    }
}
