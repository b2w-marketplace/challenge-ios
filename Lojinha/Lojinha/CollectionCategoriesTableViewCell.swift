//
//  CollectionCategoriesTableViewCell.swift
//  Lojinha
//
//  Created by Rodrigo A E Miyashiro on 11/02/17.
//  Copyright © 2017 Rodrigo Miyashiro. All rights reserved.
//

import UIKit

class CollectionCategoriesTableViewCell: UITableViewCell
{
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension CollectionCategoriesTableViewCell {
    func setCollectionViewDataSourceDelegate<deleg: UICollectionViewDataSource & UICollectionViewDelegate> (_ dataSourceDelegate: deleg, forRow row: Int)
    {
        collectionView.dataSource = dataSourceDelegate
        collectionView.delegate = dataSourceDelegate
        collectionView.tag = row
        collectionView.setContentOffset(collectionView.contentOffset, animated: false) // Stop collectionView if it was scrolling
        collectionView.reloadData()
    }
    
    var colelctionViewOffSet: CGFloat
    {
        set
        {
            collectionView.contentOffset.x = newValue
        }
        
        get
        {
            return collectionView.contentOffset.x
        }
    }
    
    func reloadCollectionView(_ notification: Notification)
    {
        self.collectionView.reloadData()
    }
}
