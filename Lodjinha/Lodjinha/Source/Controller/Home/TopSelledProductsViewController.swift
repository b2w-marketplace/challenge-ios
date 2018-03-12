//
//  TopSelledProductsViewController.swift
//  Lodjinha
//
//  Created by Guilherme Antunes on 09/03/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import UIKit

class TopSelledProductsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var topProductsTableView: UITableView!
    
    // MARK: - Properties
    private var topSelledProducts : [Product]?
    private let homeManager = HomeManager(maxConcurrentOperationCount: 200)
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadTopSelledProducts()
    }
    
    // MARK: - General Methods
    private func setup() {
        topProductsTableView.dataSource = self
        topProductsTableView.delegate = self
    }

    private func loadTopSelledProducts() {
        topProductsTableView.alpha = 0
        startLoading(view: topProductsTableView)
        homeManager.fetchTopSelledProducts { (products) in
            stopLoading()
            self.topProductsTableView.alpha = 1
            self.topSelledProducts = products()?.data
            self.topProductsTableView.reloadData()
        }
    }
    
    // MARK: - Actions

}

extension TopSelledProductsViewController : UITableViewDataSource, UITableViewDelegate, Identifiable {
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topSelledProducts?.count ?? 0
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let product = topSelledProducts?[indexPath.row] else {
            return UITableViewCell()
        }
        
        let cell : TopSelledProductTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        cell.initWithModel(product)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsViewController = ProductDetailsViewController()
        detailsViewController.setSelectedProduct(self.topSelledProducts?[indexPath.row])
        tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
