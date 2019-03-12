//
//  HomeViewController.swift
//  Lodjinha
//
//  Created by Gustavo Azevedo de Oliveira on 10/03/19.
//  Copyright © 2019 Gustavo Azevedo de Oliveira. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var productsHeaderView: UIView!
    
    let presenter = HomePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationTitle()
        self.presenter.delegate = self
        
    }
    
    private func setNavigationTitle() {
        let titleImage = UIImage(named: "nav_title")
        let titleIv = UIImageView(image: titleImage)
        self.navigationItem.titleView = titleIv
    }
    
    private func configCategoriesCollection() {
        if let flowLayout = self.categoriesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 100, height: 80)
            flowLayout.sectionInset.left = 10.0
            flowLayout.sectionInset.right = 10.0
        }
    }
    
    func configureProductsTable() {
        self.productsTableView.estimatedRowHeight = 100.0
        self.productsTableView.rowHeight = UITableView.automaticDimension
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Presenter Delegate
extension HomeViewController: HomePresenterDelegate {
    func reloadProducts() {
        self.productsTableView.reloadData()
    }
    
    func reloadCategories() {
        self.categoriesCollectionView.reloadData()
    }
}

// MARK: - Categories
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.numberOfCategories
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionCell
        let categoryInfo = self.presenter.categoryInfo(atIndex: indexPath)
        
        cell.categoryIv.kf.setImage(with: categoryInfo.image)
        cell.nameLbl.text = categoryInfo.name
        
        return cell
    }
}

// MARK: - Products
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.mostSoldProductsNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableCell
        let productInfo = self.presenter.productInfo(atIndex: indexPath)
        
        cell.photoIv.kf.setImage(with: productInfo.photo)
        cell.nameLbl.text = productInfo.name
        cell.priceBeforeLbl.attributedText = productInfo.oldPrice
        cell.priceNowLbl.text = productInfo.newPrice
        
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.productsHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
}
