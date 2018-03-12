//
//  ProductListByCategoryViewController.swift
//  Lodjinha
//
//  Created by Guilherme Antunes on 11/03/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import UIKit

class ProductListByCategoryViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var productsListTableView: UITableView!
    
    // MARK: - Properties
    private var productsList : [Product]?
    private let manager = ProductsByCategoryManager(maxConcurrentOperationCount: 200)
    private var categoryId : Int = 0
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadProducts(forId: categoryId)
    }
    
    // MARK: - General Methods
    private func setup() {
        productsListTableView.dataSource = self
        productsListTableView.delegate = self
        let nibName = UINib(nibName: ProductTableViewCell.reuseIdentifier, bundle: nil)
        productsListTableView.register(nibName, forCellReuseIdentifier: ProductTableViewCell.reuseIdentifier)
    }
    
    private func loadProducts(forId id : Int) {
        manager.fetchProductsList(forCategory: id) { (products) in
            self.productsList = products()?.data
            self.productsListTableView.reloadData()
        }
    }
    
    public func setCategoryId(_ id : Int, andTitle title : String) {
        self.categoryId = id
        self.title = title
    }
    
    // MARK: - Actions

}

extension ProductListByCategoryViewController : UITableViewDataSource, UITableViewDelegate, Identifiable {
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsList?.count ?? 0
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let product = productsList?[indexPath.row] else {
            return UITableViewCell()
        }
        
        let cell : ProductTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        cell.initWithModel(product)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsViewController = ProductDetailsViewController()
        detailsViewController.setSelectedProduct(self.productsList?[indexPath.row])
        tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
