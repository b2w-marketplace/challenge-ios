//
//  ListProductsView.swift
//  Challenge-Alodjinha
//
//  Created by Luis Henrique Tavares Ferreira on 17/04/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit

class ListProductsView: UITableViewController {

    @IBOutlet weak var loading: UIActivityIndicatorView!
    private lazy var viewModel = ListProductsViewModel(delegate: self)
    var selected: ProductResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        viewModel.listProductsLoad()
        tableView.tableFooterView = UIView()
        registerCells()
    }
    
    func setup(transporter: ResultTransporterCategory, index: Int) {
        viewModel.setup(transporter: transporter, index: index)
    }
    
    private func setupNavBar() {
        self.navigationController?.view.tintColor = UIColor.white
        if self.viewModel.product.count > 1 {
            self.navigationItem.title = "\(self.viewModel.product[0].categoria.descricao)"
        }
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
        if viewModel.numberOfRows() != 0 {
            return viewModel.numberOfRows()
    
        } else {
            self.showAlert(withTitle: "", message: "Não existe produtos para essa categoria!")
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as? ProductViewCell else {
            return ProductViewCell()
        }
        
        cell.fill(dto: viewModel.dtoForRow(index: indexPath.row))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailView = storyboard?.instantiateViewController(withIdentifier: "detailView") as? DetailView {
            detailView.setup(transporter: viewModel.transporterProducts, index: indexPath.row)
            navigationController?.pushViewController(detailView, animated: true)
        }
    }
}

extension ListProductsView: LoadContent {
    func didLoad() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.setupNavBar()
        }
    }
}
