//
//  CategoriesViewController.swift
//  Lodjinha
//
//  Created by Guilherme Antunes on 10/03/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    // MARK: - Properties
    private var categories : [Category]?
    private let homeManager = HomeManager(maxConcurrentOperationCount: 200)
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        setup()
    }
    
    // MARK: - General Methods
    private func loadCategories() {
        homeManager.fetchCategories { (categories) in
            self.categories = categories()?.data
            self.categoriesCollectionView.reloadData()
        }
    }
    
    private func setup() {
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
    }
    
    // MARK: - Actions

}

extension CategoriesViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    internal func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let category = categories?[indexPath.item] else {
            return UICollectionViewCell()
        }
        
        let cell : CategoryCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        
        cell.initWithModel(category)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = categories?[indexPath.item].id, let title = categories?[indexPath.item].description else {
            return
        }
        
        let productsListViewController = ProductListByCategoryViewController()
        productsListViewController.setCategoryId(id, andTitle: title)
        tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(productsListViewController, animated: true)
    }
    
}
