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
    
    
    private lazy var viewModel: HomeViewModel = HomeViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView.isHidden = true
        viewModel.loadBanner()
        viewModel.loadBestSeller()
        viewModel.loadCategory()
        collectionView.dataSource = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        registerCells()
    }
    
    private func registerCells() {
        let bestSellerNib = UINib(nibName: "ProductViewCell", bundle: nil)
        tableView.register(bestSellerNib, forCellReuseIdentifier: BestSellerString.cell)
        
        let categoryNib = UINib(nibName: "CategoryViewCell", bundle: nil)
        collectionView.register(categoryNib, forCellWithReuseIdentifier: CategoryString.cell)
    }
    
    private func addBanner() {
        DispatchQueue.main.async {
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
    }
}

extension HomeView: UITableViewDataSource {
    
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
}

extension HomeView: UICollectionViewDataSource {
    
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
}

extension HomeView: LoadContent {
    func didLoad() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.collectionView.reloadData()
            self.addBanner()
        }
    }
}
