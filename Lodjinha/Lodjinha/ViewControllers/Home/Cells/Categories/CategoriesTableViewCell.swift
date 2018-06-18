//
//  CategoriesTableViewCell.swift
//  Lodjinha
//
//  Created by Matheus Pacheco Fusco on 15/06/2018.
//  Copyright © 2018 Fusco. All rights reserved.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    //MARK: - Lets and Vars
    var delegate: CellDelegate!
    var categories: [Category]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let nibCategory = UINib.init(nibName: "CategoryCollectionViewCell", bundle: Bundle(for: type(of: self)))
        
        self.collectionView.register(nibCategory, forCellWithReuseIdentifier: "categoryCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

//MARK: - UICollectionView Delegate & DataSource Methods
extension CategoriesTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let categories = self.categories {
            return categories.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let categories = self.categories {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
            cell.category = categories[indexPath.row]
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate.showProductsFromCategory(category: categories![indexPath.row])
    }
}
