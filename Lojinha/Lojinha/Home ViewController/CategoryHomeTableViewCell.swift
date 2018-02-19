//
//  CategoryHomeTableViewCell.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 13/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import UIKit

class CategoryHomeTableViewCell: UITableViewCell
{
    // MARK: - IBOutlets
    @IBOutlet weak var categoryHomeCollectionView: UICollectionView!
    
    

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


extension CategoryHomeTableViewCell
{
    func setCollectionViewDataSourceDelegate<deleg: UICollectionViewDataSource & UICollectionViewDelegate> (dataSourceDelegate: deleg, forRow row: Int)
    {
        categoryHomeCollectionView.dataSource = dataSourceDelegate
        categoryHomeCollectionView.delegate = dataSourceDelegate
        categoryHomeCollectionView.tag = row
        categoryHomeCollectionView.setContentOffset(categoryHomeCollectionView.contentOffset, animated: false)
        categoryHomeCollectionView.reloadData()
    }
    
    var collectionViewOffSet: CGFloat
    {
        set
        {
            categoryHomeCollectionView.contentOffset.x = newValue
        }
        get
        {
            return categoryHomeCollectionView.contentOffset.x
        }
    }
}
