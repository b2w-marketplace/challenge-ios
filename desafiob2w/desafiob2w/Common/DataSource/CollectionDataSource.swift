//
//  CollectionDataSource.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 18/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

class CollectionDataSource<Cell: UICollectionViewCell, Item>: NSObject, UICollectionViewDataSource where Cell: ViewCellHandler, Item == Cell.Item {
    
    let items: [Item]
    
    init(items: [Item]) {
        self.items = items
        
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as? Cell else {
            fatalError("Cell identifier \(Cell.identifier) not found")
        }
        cell.setData(self.items[indexPath.row])
        return cell
    }
    
}
