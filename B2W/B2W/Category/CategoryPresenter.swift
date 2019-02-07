//
//  CategoryPresenter.swift
//  B2W
//
//  Created by Nicholas Matos on 2/7/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit

class CategoryPresenter: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ProductListDelegate {
    let productList = ProductListVC(nibName: "ProductListVC", bundle: Bundle.main)
    let categoryInteractor = CategoryInteractor()
    var category: Category?
    
    func registerDelegate(){
        productList.delegate = self
    }
    
    func didLoad(){
        productList.collectionView.delegate = self
        productList.collectionView.dataSource = self
        
        productList.navigationItem.title = category?.categoryDescription
        
        categoryInteractor.getProductListByCategory(categoryId: category!.id!) {
            self.productList.collectionView.reloadData()
        }
    }
    
    //MARK: - UI Collection View Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryInteractor.productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductCell = collectionView.dequeueReusableCell(withReuseIdentifier: kProductCell, for: indexPath) as! ProductCell
        
        let product = categoryInteractor.productList[indexPath.row]
        cell.bind(product: product)
        
        return cell
    }
    
    //MARK: - UI Collection View Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    //MARK: - UI Collection View Delegate Flow Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: productList.view.frame.width, height: CGFloat(kProductCellHeight))
    }
}
