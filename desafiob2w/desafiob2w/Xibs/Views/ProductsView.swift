//
//  ProductsView.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 17/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

class ProductsView: UIView {
    
    private var isScroll: Bool = true
    private var isInfinite: Bool = true
    
    @IBOutlet weak var tableView: UITableView!
    private var dataSource: TableDataSource<ProductTableViewCell, ProductViewModel>!
    private var completionProdructIndex: ((_ indexCellSelected: Int) -> Void)?
    private var completionMoreProducts: (() -> Void)?
    
    
    override func awakeFromNib() {
        loadNib()
        setupPresentation(parentView: self)
        super.awakeFromNib()
        configureTable()
    }
    
    func setupView(products: [ProductViewModel], completionProdructIndex:@escaping (Int) -> Void) {
        setDataSource(products: products)
        self.completionProdructIndex = completionProdructIndex
        loadingView = LoadingViewFactory.make(parentView: self)
    }
    
    func setupView(withScroll isScroll: Bool, withInfinite isInfinite:Bool, products: [ProductViewModel], completionProdructIndex:@escaping (Int) -> Void, completionMoreProducts:@escaping () -> Void) {
        setDataSource(products: products)
        self.isScroll = isScroll
        self.isInfinite = isInfinite
        self.completionProdructIndex = completionProdructIndex
        self.completionMoreProducts = completionMoreProducts
        loadingView = LoadingViewFactory.make(parentView: self)
    }
    
    private func configureTable() {
        tableView.register(UINib(nibName: ProductTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: ProductTableViewCell.identifier)
    }
    
    private func setDataSource(products: [ProductViewModel]) {
        DispatchQueue.main.async {
            self.dataSource = TableDataSource(items: products)
            self.tableView.dataSource = self.dataSource
            self.tableView.delegate = self
            self.tableView.isHidden = false
            self.tableView.isScrollEnabled = self.isScroll
            self.tableView.reloadData()
        }
    }
}

extension ProductsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        completionProdructIndex!(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        completionMoreProducts!()
    }

}
