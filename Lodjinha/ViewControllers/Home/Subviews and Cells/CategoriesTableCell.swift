//
//  CategoriesTableCell.swift
//  Lodjinha
//
//  Created by André Assis on 15/06/18.
//  Copyright © 2018 André Assis. All rights reserved.
//

import UIKit

protocol CategoriesTableCellDelegate {
    func selectedCategory(_ category: CategoryModel)
}

class CategoriesTableCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let categoryCellIdentifier = "categoryCollectionCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var categories: [CategoryModel] = []
    
    var delegate: CategoriesTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupWithCategories(_ categories: [CategoryModel]) {
        self.categories = categories
        collectionView.reloadData()
    }
    
    // MARK: - CollectionView
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.height, height: collectionView.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let category = categories.itemFor(index: indexPath),
            let cell: CategoryCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellIdentifier, for: indexPath) as? CategoryCollectionCell {
            cell.setupWithCategory(category)
            return cell
        }
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellIdentifier, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if let category = categories.itemFor(index: indexPath) {
            delegate?.selectedCategory(category)
        }
    }
    
}

class CategoryCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCategory: AlamofireImageView!
    @IBOutlet weak var labelCategory: UILabel!
    
    func setupWithCategory(_ category: CategoryModel) {
        imageCategory.loadImageFor(url: category.imgUrl, placeholderImg: nil)
        labelCategory.text = category.description
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageCategory.image = nil
    }
    
}
