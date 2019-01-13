//
//  CategoryTableViewCell.swift
//  Lodjinha
//
//  Created by Lucas Gonçalves Serrano on 12/01/19.
//  Copyright © 2019 Lucas Gonçalves Serrano. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    private enum CellIdentifiers {
        static let category = "CategoryCell"
    }

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!

    var categories: [Category]?

    override func awakeFromNib() {
        super.awakeFromNib()

        indicatorView.hidesWhenStopped = true
        indicatorView.color = .WarmPurple

        collectionView.dataSource = self
        collectionView.delegate = self

        addTopBorder(color: .White, width: 1.0)
        addBottomBorder(color: .White, width: 1.0)

        selectionStyle = .none
    }

    func configure(with categories: [Category]?) {
        self.categories = categories
        if categories != nil {
            indicatorView.stopAnimating()
        } else {
            indicatorView.startAnimating()
        }
    }
}

extension CategoryTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }

}

extension CategoryTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let categories = categories, categories.count > indexPath.row {
            NotificationCenter.default.post(name: .init("clickedCategory"), object: nil, userInfo: ["category": categories[indexPath.row]])
        }
    }
}

extension CategoryTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.category, for: indexPath) as! CategoryCollectionViewCell
        if let categories = categories, categories.count > indexPath.row {
            cell.configure(with: categories[indexPath.row])
        } else {
            cell.configure(with: nil)
        }
        return cell
    }
}
