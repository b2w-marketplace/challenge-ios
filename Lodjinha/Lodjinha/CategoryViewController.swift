//
//  CategoryViewController.swift
//  Lodjinha
//
//  Created by Gustavo Azevedo de Oliveira on 11/03/19.
//  Copyright © 2019 Gustavo Azevedo de Oliveira. All rights reserved.
//

import UIKit

class CategoryViewController: UITableViewController {
    let presenter = CategoryPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "ProductTableCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "ProductCell")
        self.presenter.delegate = self
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // MARK: - Products
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.productsNumber
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableCell
        let productInfo = self.presenter.productInfo(atIndex: indexPath)
        
        cell.photoIv.kf.setImage(with: productInfo.photo)
        cell.nameLbl.text = productInfo.name
        cell.priceBeforeLbl.attributedText = productInfo.oldPrice
        cell.priceNowLbl.text = productInfo.newPrice
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ProductSegue", sender: indexPath)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let productVc = segue.destination as? ProductInfoViewController, let index = sender as? IndexPath {
            productVc.presenter.product = self.presenter.productAtIndex(indexPath: index)
        }
    }
}


// MARK: - Presenter Delegate
extension CategoryViewController: CategoryPresenterDelegate {
    func reloadCategoryProducts() {
        self.tableView.reloadData()
    }
}
