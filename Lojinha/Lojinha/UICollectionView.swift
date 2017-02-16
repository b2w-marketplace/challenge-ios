//
//  CollectionView.swift
//  Lojinha
//
//  Created by Rodrigo A E Miyashiro on 11/02/17.
//  Copyright © 2017 Rodrigo Miyashiro. All rights reserved.
//

import UIKit

// MARK: - CollectionView DataSource
// MARK: Extension HomeViewController
extension HomeViewController: UICollectionViewDataSource
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let CellIdentifier = "CategoryCollectionCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath) as! CategoryCollectionViewCell
        
        let item = indexPath.item
        let category = categories[item]
        
        Request.getImage(url: category.urlImage) { (imgData) in
            cell.imgCategory.image = UIImage(data: imgData)
        }
        
        cell.lblNameCategory.text = category.description
        
        return cell
    }
}


// MARK: - CollectionView Delegate
// MARK: Extension HomeViewController
extension HomeViewController: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
