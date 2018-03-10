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
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadTopSelledProducts()
    }
    
    // MARK: - General Methods
    private func setup() {
        topProductsTableView.dataSource = self
        topProductsTableView.heightAnchor.constraint(equalToConstant: topProductsTableView.contentSize.height)
    }

    private func loadTopSelledProducts() {
        startLoading(view: topProductsTableView)
        homeManager.fetchTopSelledProducts { (products) in
            stopLoading()
            self.topSelledProducts = products()?.data
            self.topProductsTableView.reloadData()
        }
    }
    
    // MARK: - Actions

}

extension TopSelledProductsViewController : UITableViewDataSource, Identifiable {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topSelledProducts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let product = topSelledProducts?[indexPath.row] else {
            return UITableViewCell()
        }
        
        let cell : TopSelledProductTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        cell.initWithModel(product)
        
        return cell
    }
    
}
