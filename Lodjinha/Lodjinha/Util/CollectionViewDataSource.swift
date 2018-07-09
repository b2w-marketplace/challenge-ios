//
//  CollectionViewDataSource.swift
//  Lodjinha
//
//  Created by Vitor Ferraz on 09/07/2018.
//  Copyright © 2018 Vitor Ferraz. All rights reserved.
//

import UIKit

class CollectionViewDataSource<Cell :UICollectionViewCell, ViewModel> : NSObject, UICollectionViewDataSource{
    
    
    private var cellIdentifier :String!
    private var items :[ViewModel]!
    var configureCell :(Cell, ViewModel) -> Void
    
    init(cellIdentifier :String, items :[ViewModel], configureCell: @escaping (Cell, ViewModel) -> Void) {
        
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? Cell else {return UICollectionViewCell()}
        
        let item = self.items[indexPath.row]
        self.configureCell(cell, item)
        
        return cell
    }
    
    
    
}
