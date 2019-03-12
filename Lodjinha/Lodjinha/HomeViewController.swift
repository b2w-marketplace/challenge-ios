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
        
        self.configCategoriesCollection()
        self.configureProductsTable()
    }
    
    private func setNavigationTitle() {
        let titleImage = UIImage(named: "nav_title")
        let titleIv = UIImageView(image: titleImage)
        self.navigationItem.titleView = titleIv
    }
    
    private func configCategoriesCollection() {
        if let flowLayout = self.categoriesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.sectionInset.left = 10.0
            flowLayout.sectionInset.right = 10.0
        }
    }
    
    func configureProductsTable() {
        self.productsTableView.estimatedRowHeight = 100.0
        self.productsTableView.rowHeight = UITableView.automaticDimension
        
        let cellNib = UINib(nibName: "ProductTableCell", bundle: nil)
        self.productsTableView.register(cellNib, forCellReuseIdentifier: "ProductCell")
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let categoryController = segue.destination as? CategoryViewController, let index = sender as? IndexPath {
            let categoryId = self.presenter.categoryId(forIndexPath: index)
            categoryController.presenter.loadCategory(categoryId: categoryId)
            categoryController.title = self.presenter.categoryInfo(atIndex: index).name
        }
        else if let productVc = segue.destination as? ProductInfoViewController, let index = sender as? IndexPath {
            productVc.presenter.product = self.presenter.productAtIndex(indexPath: index)
        }
    }
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
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "CategorySegue", sender: indexPath)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "ProductSegue", sender: indexPath)
    }
}
