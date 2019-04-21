//
//  HomeView.swift
//  Challenge-Alodjinha
//
//  Created by Luis Ferreira on 16/04/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit

class HomeView: UIViewController {

    @IBOutlet weak var bannerScrollView: UIScrollView!
    @IBOutlet weak var bannerPageControl: UIPageControl!
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    private var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    
    private lazy var viewModel: HomeViewModel = HomeViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView.isHidden = true
        
        viewModel.loadBanner()
        viewModel.loadBestSeller()
        viewModel.loadCategory()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        bannerScrollView.delegate = self
        
        registerCells()
        drawNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        drawNavigation()
    }
    
    private func registerCells() {
        let bestSellerNib = UINib(nibName: "ProductViewCell", bundle: nil)
        tableView.register(bestSellerNib, forCellReuseIdentifier: BestSellerString.cell)
        
        let categoryNib = UINib(nibName: "CategoryViewCell", bundle: nil)
        collectionView.register(categoryNib, forCellWithReuseIdentifier: CategoryString.cell)
    }
    
    private func addBanner() {
            self.bannerScrollView.contentSize.width = self.view.bounds.width * CGFloat(self.viewModel.banners.count)

            for (index, _) in self.viewModel.banners.enumerated() {
                if let bannerView = Bundle.main.loadNibNamed("BannerView", owner: self, options: nil)?.first as? BannerView {
                    bannerView.fill(dto: self.viewModel.dtoForImage(index: index))
                    bannerView.bannerImage.contentMode = .scaleToFill
                    self.bannerScrollView.addSubview(bannerView)
                    bannerView.frame.size.width = self.bannerScrollView.bounds.size.width
                    bannerView.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
                }
            }
            self.bannerPageControl.numberOfPages = self.viewModel.banners.count
    }
    
    private func drawNavigation() {
        let navigation = UIView()
        let text = UILabel()
        text.text = " "
        text.font = UIFont(name: "Pacifico-Regular", size: 20)
        text.textColor = UIColor.white
        text.sizeToFit()
        text.center = navigation.center
        text.textAlignment = NSTextAlignment.center

        let image = UIImageView()
        image.image = UIImage(named: "logoNavbar")
        let imageAspect = image.image!.size.width/image.image!.size.height
        image.frame = CGRect(x: text.frame.origin.x-text.frame.size.height*imageAspect,
                             y: text.frame.origin.y, width: text.frame.size.height*imageAspect,
                             height: text.frame.size.height)
        image.contentMode = UIView.ContentMode.scaleAspectFill

        navigation.addSubview(text)
        navigation.addSubview(image)

        self.navigationItem.titleView = navigation
        navigation.sizeToFit()
    }
}

extension HomeView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsBestSeller()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BestSellerString.cell, for: indexPath) as? ProductViewCell else {
            return ProductViewCell()
        }
            
        cell.fill(dto: viewModel.dtoForRowBestSellet(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailView = storyboard?.instantiateViewController(withIdentifier: "detailView") as? DetailView {
            detailView.setup(transporter: viewModel.transporterProducts, index: indexPath.row)
            navigationController?.pushViewController(detailView, animated: true)
        }
    }
}

extension HomeView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsCategory()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryString.cell, for: indexPath) as? CategoryViewCell else {
            return CategoryViewCell()
        }
        
        cell.fill(dto: viewModel.dtoForRowCategory(index: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let listProductsView = storyboard?.instantiateViewController(withIdentifier: "listProductsView") as? ListProductsView {
            listProductsView.setup(transporter: viewModel.transporterCategory, index: indexPath.row)
            navigationController?.pushViewController(listProductsView, animated: true)
        }
    }
}

extension HomeView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = bannerScrollView.contentOffset.x / bannerScrollView.frame.size.width
        bannerPageControl.currentPage = Int(pageNumber)
    }
}

extension HomeView: LoadContent {
    func didLoad() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.collectionView.reloadData()
            self.loading.isHidden = true
            self.addBanner()
        }
    }
}
