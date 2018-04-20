//
//  ProductTableViewController.swift
//  a-lodjinha
//
//  Created by Daniel Rocha on 4/19/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import UIKit

enum ModeList {
    case product
    case bestSeller
}

protocol ProductTableViewControllerDelegate: class {
    func showDetail(product: Product)
}

class ProductTableViewController: UITableViewController, ProductPresenterDelegate {

    var modeList: ModeList = .product
    var categoryID: Int?
    var categoryName: String?
    var presenter : ProductPresenter?
    var products: [Product] = []
    
    weak var delegate: ProductTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.categoryName ?? ""
        
        self.presenter?.delegate = self
        
        self.load()

    }
    
    func load() {
        if modeList == .product {
            self.presenter?.getProducts(categoryID: self.categoryID ?? 0)
        } else {
            self.presenter?.getBestSellers()
        }
    }
    
    // MARK: ProductPresenterDelegate
    
    func showProducts(products: [Product]) {
        self.products = products
        self.tableView.reloadData()
    }
    
    func showLoading(loading: Bool) {
        if loading {
            LoadingViewController.shared.show()
        } else {
            LoadingViewController.shared.dismiss()
        }
    }
    
    func showConnectionError() {
        ConnectionErrorController.shared.showConnectionError(target: self, action: #selector(update))
    }
    
    func update() {
        ConnectionErrorController.shared.dismissConnectionError()
        self.load()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        
        AlamofireImageNetworking().requestImage(url: self.products[indexPath.row].urlImagem, success: { (image) in
            cell.productImage.image = image
        }) { (error) in
            cell.productImage = nil
        }
        
        cell.name.text = self.products[indexPath.row].name + " - " + self.products[indexPath.row].description
        
        let oldPrice = String.init(format: "De %.02f", self.products[indexPath.row].oldPrice)
            .replacingOccurrences(of: ".", with: ",")
        let price = String.init(format: "Por %.02f", self.products[indexPath.row].price)
            .replacingOccurrences(of: ".", with: ",")
        
        cell.oldPrice.text = oldPrice
        cell.price.text = price

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = self.products[indexPath.row]
        
        if self.modeList == .product {
            self.presenter?.callDetails(product: product)
        } else {
            self.delegate?.showDetail(product: product)
        }
    }
    
}
