//
//  HomeViewController.swift
//  Lodjinha
//
//  Created by Victor Hideki Rezende Takai on 26/12/18.
//  Copyright © 2018 Kalivos. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {

    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var productsTableViewHeight: NSLayoutConstraint!
    
    private var products = [Produto]()
    private var categories = [Categoria]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCollectionView()
        loadCategories()
        loadProducts()
    }
    
    private func loadCategories() {
        Network.getCategorias { (response) in
            dump(response.data)
            inMainAsync {
                self.categories = response.data
                self.categoriesCollectionView.reloadData()
            }
        }
    }
    
    private func loadProducts() {
        Network.getProdutosMaisVendidos { (response) in
            dump(response.data)
            inMainAsync {
                self.products = response.data
                self.productsTableView.reloadData()
            }
        }
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let obj = object as? UITableView {
            if obj == productsTableView && keyPath == "contentSize" {
                productsTableViewHeight.constant = productsTableView.contentSize.height
            }
        }
    }
    
    private func setupTableView() {
        productsTableView.register(UINib(nibName: ProductCell.nameOfClass, bundle: nil), forCellReuseIdentifier: ProductCell.nameOfClass)
        productsTableView.rowHeight = UITableView.automaticDimension
        productsTableView.estimatedRowHeight = 85
        productsTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    private func setupCollectionView() {
        categoriesCollectionView.register(UINib(nibName: CategoryCell.nameOfClass, bundle: nil), forCellWithReuseIdentifier: CategoryCell.nameOfClass)
    }

}

//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(CategoryViewController(titleName: "Teste"), animated: true)
    }
    
}

//MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.nameOfClass, for: indexPath) as! CategoryCell
        let category = categories[indexPath.row]
        
        cell.nameLabel.text = category.descricao
        cell.iconImageView.kf.indicatorType = .activity
        cell.iconImageView.kf.setImage(with: URL(string: category.urlImagem),
                                       placeholder: UIImage(named: "question"))
        
        return cell
    }
    
}

//MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(DetailViewController(titleName: "Teste"), animated: true)
    }
    
}

//MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.nameOfClass) as! ProductCell
        let product = products[indexPath.row]
        
        cell.nameLabel.text = product.nome
        cell.iconImageView.kf.indicatorType = .activity
        cell.iconImageView.kf.setImage(with: URL(string: product.urlImagem),
                                       placeholder: UIImage(named: "question"))
        cell.oldPriceLabel.text = "De: \(moneyFormatter(product.precoDe))"
        cell.newPriceLabel.text = "Por \(moneyFormatter(product.precoPor))"
        
        return cell
    }
    
    
}
