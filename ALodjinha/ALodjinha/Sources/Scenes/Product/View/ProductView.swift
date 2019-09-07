//
//  ProductView.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 06/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit

class ProductView: UIViewController {

    @IBOutlet weak var tableView: AlodjinhaTableView!
    
    private lazy var viewModel: ProductViewModel = ProductViewModel(delegate: self)
    private var category: Category?
    weak var delegate: HomeViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setup(category: Category) {
        self.category = category
        viewModel.setupInitial(category: category)
    }
    
    func setupView() {
        tableView.tableFooterView = UIView()
        viewModel.loadProduct()
        tableView.dataSource = self
        tableView.delegate = self
        registerCell()
        setupNavBar()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func registerCell() {
        let productNibName = UINib(nibName: ProductString.ProductTableViewCell, bundle: nil)
        tableView.register(productNibName, forCellReuseIdentifier: ProductString.ProductCell)
    }
    
    private func setupNavBar() {
        self.navigationItem.title = category?.descricao ?? ""
    }
}

extension ProductView: LoadContentable {
    func didLoad() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ProductView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.numberOfRows() == 0 {
            let alert = UIAlertController(title: "Atenção", message: "Produto indisponível no momento", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (dismiss) in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true)
        }
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductString.ProductCell, for: indexPath) as? ProductTableViewCell else {
            return ProductTableViewCell()
        }
        if viewModel.isLastIndex(indexPath: indexPath) {
            viewModel.loadMore()
        }
        cell.fill(dto: viewModel.dtoForRows(indexPath: indexPath))
        return cell
    }
}

extension ProductView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.fetchProduct(product: viewModel.productTransporter(indexPath: indexPath))
    }
}
