//
//  ProductListVC.swift
//  B2W
//
//  Created by Nicholas Matos on 2/7/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit

protocol ProductListDelegate {
    func didLoad()
}

class ProductListVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var delegate: ProductListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        delegate?.didLoad()
    }
    
    func registerCells(){
        collectionView.register(UINib(nibName: kProductCell, bundle: nil), forCellWithReuseIdentifier: kProductCell)
    }
}
