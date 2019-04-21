//
//  ListProductsView.swift
//  Challenge-Alodjinha
//
//  Created by Luis Henrique Tavares Ferreira on 17/04/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit

class ListProductsView: UITableViewController {

    private lazy var viewModel = ListProductsViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        viewModel.listProductsLoad()
        registerCells()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Valtar", style: .plain, target: nil, action: nil)
    }
    
    func setup(transporter: ResultTransporterCategory, index: Int) {
        viewModel.setup(transporter: transporter, index: index)
    }
    
    private func registerCells() {
        let bestSellerNib = UINib(nibName: "ProductViewCell", bundle: nil)
        self.tableView.register(bestSellerNib, forCellReuseIdentifier: "productCell")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as? ProductViewCell else {
            return ProductViewCell()
        }
        
        cell.fill(dto: viewModel.dtoForRow(index: indexPath.row))
        return cell
    }
}

extension ListProductsView: LoadContent {
    func didLoad() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
