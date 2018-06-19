//
//  CategoriesView.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 17/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

class CategoriesView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var dataSource: CollectionDataSource<CategoryCollectionViewCell, CategoryViewModel>!
    override func awakeFromNib() {
        loadNib()
        super.awakeFromNib()
        configureCollection()
    }
    
    func setupView(categories: [CategoryViewModel]) {
        setDataSource(categories: categories)
    }
    
    private func configureCollection() {
        collectionView.register(UINib(nibName: CategoryCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
    
    private func setDataSource(categories: [CategoryViewModel]) {
        DispatchQueue.main.async {
            self.dataSource = CollectionDataSource(items: categories)
            self.collectionView.dataSource = self.dataSource
            self.collectionView.delegate = self
            self.collectionView.reloadData()
        }
    }

}

extension CategoriesView: UICollectionViewDelegate {
    
}
