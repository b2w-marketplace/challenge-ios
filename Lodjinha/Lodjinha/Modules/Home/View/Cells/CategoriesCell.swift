//
//  CategoriesCell.swift
//  Lodjinha
//
//  Created by Marcos on 21/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit

protocol CategoriesCellDelegate: class {
    
    func categoriesCell(cell: CategoriesCell, didSelectItemAt indexPath: IndexPath)
}

final class CategoriesCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var categoryList: [Category] = []
    
    weak var delegate: CategoriesCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAccessibilityIdentifiers()
        setupCollectionView()
    }

    private func setupAccessibilityIdentifiers() {
        collectionView.accessibilityIdentifier = "collectionView"
    }
    
    private func setupCollectionView() {
        collectionView.register(cellType: CategoryCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        collectionView.dataSource = self
        collectionView.delegate = self
        //collectionView.isPagingEnabled = true
    }
    
    func setup(categoryList: [Category]) {
        self.categoryList = categoryList
        collectionView.reloadData()
    }
    
}
// MARK: - UICollectionViewDataSource
extension CategoriesCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = categoryList[indexPath.row]
        let cell: CategoryCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setup(category: category)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension CategoriesCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.categoriesCell(cell: self, didSelectItemAt: indexPath)
        }
    }
    
}
