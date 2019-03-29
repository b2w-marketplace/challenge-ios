//
//  CategoriesCarouselTableViewCell.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 28/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import UIKit

class CategoriesCarouselTableViewCell: UITableViewCell {
    
    static let identifier: String = "CategoriesCarouselTableViewCell"
    
    let defaultCellWidth: CGFloat = 80
    let defaultCellHeight: CGFloat = 80
    let cellMarginSpace: CGFloat = 10
    let cellSeparatorSpace: CGFloat = 10
    let cellHorizontalInsetSpace: CGFloat = 10
    let cellVerticalInsetSpace: CGFloat = 4
    
    lazy var shortcutsCollectionView: UICollectionView! = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = self.cellSeparatorSpace
        flowLayout.sectionInset = UIEdgeInsets(top: self.cellVerticalInsetSpace, left: self.cellHorizontalInsetSpace, bottom: self.cellVerticalInsetSpace, right: self.cellHorizontalInsetSpace)
        flowLayout.minimumLineSpacing = self.cellSeparatorSpace
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    var topSeparator: UIView = {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor.lightGray
        return separator
    }()
    
    var bottomSeparator: UIView = {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = UIColor.lightGray
        return separator
    }()
    
    var categories: [ProductCategory] = []
    
    func configure(with categories: [ProductCategory]) {
        self.categories = categories
        self.backgroundColor = .clear
        shortcutsCollectionView.reloadData()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(shortcutsCollectionView)
        addSubview(topSeparator)
        addSubview(bottomSeparator)
        shortcutsCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "categoryCell")
        setupLayout()
    }
    
    func setupLayout() {
        shortcutsCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: cellMarginSpace).isActive = true
        shortcutsCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -cellMarginSpace).isActive = true
        shortcutsCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: cellMarginSpace).isActive = true
        shortcutsCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: -cellMarginSpace).isActive = true
        
        topSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        topSeparator.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        topSeparator.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        topSeparator.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        bottomSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        bottomSeparator.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomSeparator.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bottomSeparator.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implement")
    }
}


extension CategoriesCarouselTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
        
        cell.configure(with: categories[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: defaultCellWidth, height: defaultCellHeight)
    }
    
}
