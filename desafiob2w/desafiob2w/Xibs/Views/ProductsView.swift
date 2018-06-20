//
//  ProductsView.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 17/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

class ProductsView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    private var dataSource: TableDataSource<ProductTableViewCell, ProductViewModel>!
    private var completion: ((_ indexCellSelected: Int) -> Void)?
    
    override func awakeFromNib() {
        loadNib()
        setupPresentation(parentView: self)
        super.awakeFromNib()
        configureTable()
    }
    
    func setupView(products: [ProductViewModel], completion:@escaping (Int) -> Void) {
        setDataSource(products: products)
        self.completion = completion
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
            self.tableView.reloadData()
        }
    }

}

extension ProductsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        completion!(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
