//
//  CategoryViewController.swift
//  Lodjinha
//
//  Created by Victor Hideki Rezende Takai on 28/12/18.
//  Copyright © 2018 Kalivos. All rights reserved.
//

import UIKit
import SwiftyAttributes

class ProductsViewController: UIViewController {

    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var productsIndicator: UIActivityIndicatorView!
    
    private var titleName: String
    private var categoriaId: Int
    private var offset = 0
    private var limit = 20
    private var products = [Produto]()
    private var shouldLoadMore = false
    private var contentOffsetY: CGFloat = 0
    
    init(titleName: String, categoriaId: Int) {
        self.titleName = titleName
        self.categoriaId = categoriaId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        loadProducts()
    }
    
    private func loadProducts() {
        let lastOffset = offset
        Network.getProdutos(offset: offset, limit: limit, categoriaId: categoriaId) { [unowned self] (response) in
            dump(response.data)
            inMainAsync {
                self.productsIndicator.stopAnimating()
                self.products.append(contentsOf: response.data)
                self.offset = self.products.count
                self.shouldLoadMore = self.offset != lastOffset
                self.productsTableView.reloadData()
                self.productsTableView.setContentOffset(CGPoint(x: 0, y: self.contentOffsetY), animated: false)
            }
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.title = titleName
    }
    
    private func setupTableView() {
        productsTableView.register(UINib(nibName: ProductCell.nameOfClass, bundle: nil), forCellReuseIdentifier: ProductCell.nameOfClass)
        productsTableView.register(UINib(nibName: LoadingCell.nameOfClass, bundle: nil), forCellReuseIdentifier: LoadingCell.nameOfClass)
        productsTableView.rowHeight = UITableView.automaticDimension
        productsTableView.estimatedRowHeight = 85
        productsTableView.tableFooterView = footerPlaceholder(width: productsTableView.frame.size.width)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        contentOffsetY = scrollView.contentOffset.y
    }
    
}

//MARK: - UITableViewDelegate
extension ProductsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        navigationController?.pushViewController(DetailViewController(titleName: product.nome, produtoId: product.id), animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRow = products.count - 1
        if indexPath.row == lastRow && shouldLoadMore {
            inMainAsyncAfter(interval: .milliseconds(1000)) {
                self.loadProducts()
            }
        }
    }
    
}

//MARK: - UITableViewDataSource
extension ProductsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count + (shouldLoadMore ? 1 : 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lastRow = products.count - (shouldLoadMore ? 0 : 1)
        if indexPath.row == lastRow && shouldLoadMore {
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.nameOfClass, for: indexPath) as! LoadingCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.nameOfClass) as! ProductCell
            let product = products[indexPath.row]
            
            cell.nameLabel.text = product.nome
            cell.iconImageView.kf.indicatorType = .activity
            cell.iconImageView.kf.setImage(with: URL(string: product.urlImagem),
                                           placeholder: UIImage(named: "question"))
            let text = "De: \(moneyFormatter(product.precoDe))"
            cell.oldPriceLabel.attributedText = text.withStrikethroughColor(.lightGray).withStrikethroughStyle(.single)
            cell.newPriceLabel.text = "Por \(moneyFormatter(product.precoPor))"
            
            return cell
        }
    }
    
    
}

