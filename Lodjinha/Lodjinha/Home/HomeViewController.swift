//
//  HomeViewController.swift
//  Lodjinha
//
//  Created by Victor Hideki Rezende Takai on 26/12/18.
//  Copyright © 2018 Kalivos. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    private let bannerHeight: CGFloat = 140.0
    private let tableViewHeight: CGFloat = 300

    @IBOutlet weak var bannersScrollView: UIScrollView!
    @IBOutlet weak var bannersPageControl: UIPageControl!
    @IBOutlet weak var bannersIndicator: UIActivityIndicatorView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var categoriesIndicator: UIActivityIndicatorView!
    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var productsTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var productsIndicator: UIActivityIndicatorView!
    
    private var banners = [Banner]()
    private var products = [Produto]()
    private var categories = [Categoria]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCollectionView()
        loadBanners()
        loadCategories()
        loadProducts()
    }
    
    private func loadBanners() {
        APIManager.getBanners { (response) in
            switch response {
            case .success(_, let result):
                self.bannersIndicator.stopAnimating()
                self.banners = result.data
                self.setupScrollView()
            case .error(let message):
                print(message)
            }
        }
    }
    
    private func loadCategories() {
        APIManager.getCategorias { [unowned self] (response) in
            switch response {
            case .success(_, let result):
                self.categoriesIndicator.stopAnimating()
                self.categories = result.data
                self.categoriesCollectionView.reloadData()
            case .error(let message):
                print(message)
            }
        }
    }
    
    private func loadProducts() {
        APIManager.getProdutosMaisVendidos { [unowned self] (response) in
            switch response {
            case .success(_, let result):
                self.productsIndicator.stopAnimating()
                self.products = result.data
                self.productsTableView.reloadData()
            case .error(let message):
                print(message)
            }
        }
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let obj = object as? UITableView, obj == productsTableView, keyPath == "contentSize" {
            var height = productsTableView.contentSize.height
            if round(height) == 0 {
                height = tableViewHeight
            }
            productsTableViewHeight.constant = height
        }
    }

}

//MARK: - UIScrollViewDelegate
extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        bannersPageControl.currentPage = Int(pageIndex)
    }
    
}

//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        navigationController?.pushViewController(ProductsViewController(titleName: category.descricao, categoriaId: category.id), animated: true)
    }
    
}

//MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.nameOfClass, for: indexPath) as! CategoryCell
        cell.setupCell(categories[indexPath.row])
        return cell
    }
    
}

//MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        navigationController?.pushViewController(DetailViewController(titleName: product.nome, produtoId: product.id), animated: true)
    }
    
}

//MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.nameOfClass) as! ProductCell
        cell.setupCell(products[indexPath.row])
        return cell
    }
    
}

//MARK: - Setups
extension HomeViewController {
    
    private func setupScrollView() {
        bannersPageControl.numberOfPages = banners.count
        
        bannersScrollView.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        
        let width = view.frame.width
        bannersScrollView.contentSize = CGSize(width: width * CGFloat(banners.count), height: bannerHeight)
        bannersScrollView.isPagingEnabled = true
        
        for i in 0 ..< banners.count {
            let frame = CGRect(x: width * CGFloat(i), y: 0, width: width, height: bannerHeight)
            let imageView = UIImageView(frame: frame)
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: URL(string: banners[i].urlImagem))
            bannersScrollView.addSubview(imageView)
        }
        
        let shadowSize: CGFloat = 10
        let rect = CGRect(x: bannersScrollView.frame.origin.x - shadowSize / 2,
                          y: bannersScrollView.frame.origin.y - shadowSize / 2,
                          width: width * CGFloat(banners.count) + shadowSize,
                          height: bannerHeight + shadowSize)
        
        let shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: 0)
        
        bannersScrollView.layer.masksToBounds = false
        bannersScrollView.layer.shadowColor = UIColor.black.cgColor
        bannersScrollView.layer.shadowOffset = CGSize.zero
        bannersScrollView.layer.shadowOpacity = 0.5
        bannersScrollView.layer.shadowPath = shadowPath.cgPath
    }
    
    private func setupTableView() {
        productsTableView.register(UINib(nibName: ProductCell.nameOfClass, bundle: nil), forCellReuseIdentifier: ProductCell.nameOfClass)
        productsTableView.rowHeight = UITableView.automaticDimension
        productsTableView.estimatedRowHeight = 85
        productsTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        productsTableView.tableFooterView = footerPlaceholder(width: productsTableView.frame.size.width)
    }
    
    private func setupCollectionView() {
        categoriesCollectionView.register(UINib(nibName: CategoryCell.nameOfClass, bundle: nil), forCellWithReuseIdentifier: CategoryCell.nameOfClass)
    }
    
}
