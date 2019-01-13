//
//  CategoryTableViewCell.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 07/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import UIKit

protocol CategoryCellDelegate: class {
    func didSelect(category: CategoryModel)
}

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    enum CategoryCellDataSource {
        case category(CategoryModel)
    }
    
    weak var delegate: CategoryCellDelegate?
    fileprivate var dataSource: [CategoryCellDataSource] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clean()
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clean()
    }
    
    final fileprivate func setup() {
        collectionView.isAccessibilityElement = true
        collectionView.accessibilityIdentifier = "CategoryCollectionView"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 100.0, height: 120.0)
        layout.itemSize = CGSize(width: 100.0, height: 120.0)
        layout.minimumInteritemSpacing = 8.0
        layout.minimumLineSpacing = 8.0
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        registerCells()
    }
    
    final fileprivate func clean() {
        dataSource.removeAll()
        collectionView.reloadData()
    }
    
    final fileprivate func registerCells() {
        collectionView.registerCell(CategoryCollectionViewCell.self)
    }
}

//MARK: Public methods
extension CategoryTableViewCell {
    public func constructWith(categories: [CategoryModel], delegate: CategoryCellDelegate?) {
        
        categories.forEach { (model) in
            dataSource.append(.category(model))
        }
        collectionView.reloadData()
        self.delegate = delegate
    }
}

//MARK: CollectionView DataSource & Delegate
extension CategoryTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch dataSource[indexPath.row] {
        case .category(let model):
            guard let cell = collectionView.dequeueReusableCell(CategoryCollectionViewCell.self, indexPath: indexPath) else {
                return UICollectionViewCell()
            }
            cell.constructWith(name: model.description, imageUrl: model.urlImagem)
            cell.accessibilityIdentifier = "CategoryCollectionViewCell\(indexPath.row)"
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch dataSource[indexPath.row] {
        case .category(let model):
            delegate?.didSelect(category: model)
        }
    }
}
