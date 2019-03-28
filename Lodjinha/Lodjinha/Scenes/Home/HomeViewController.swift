//
//  HomeViewController.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 25/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bannersView: HomeBannersView!
    
    var viewModel: HomeViewModelType!
    var configurator: HomeConfiguratorProtocol!
    
    convenience init() {
        self.init(nibName: String(describing: HomeViewController.self), bundle: Bundle.main)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CategoriesCarouselTableViewCell.self, forCellReuseIdentifier: "categoriesCell")
        tableView.register(UINib(nibName: "TopSellingProductTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "TopSellingProductCell")
        tableView.register(UINib(nibName: "HomeTableHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "HomeTableHeaderView")
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        let titleV = UILabel(frame: CGRect(x: view.frame.width / 4, y: 0, width: view.frame.width / 2, height: 44))
        titleV.text = "Title View"
        titleV.backgroundColor = UIColor.lightGray
        self.navigationItem.titleView = titleV
        
        configurator.configure(viewController: self)
        viewModel.loadBanners()
        viewModel.loadCategories()
        viewModel.loadTopSellingProducts()
    }
    
}

extension HomeViewController: HomeServicesDelegate {
    
    func didLoadBanners() {
        bannersView.updateBanners(banners: viewModel.banners)
    }
    
    func didLoadCategories() {
        tableView.reloadSections(IndexSet(0..<1), with: UITableView.RowAnimation.fade)
    }
    
    func didLoadTopSellingProducts() {
        tableView.reloadSections(IndexSet(1..<2), with: UITableView.RowAnimation.fade)
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.homeSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let homeSection = viewModel.homeSections[section]
        switch homeSection {
        case .categories:
            return 1
        case .topSellingProducts:
            return viewModel.topSellingProducts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeSection = viewModel.homeSections[indexPath.section]
        switch homeSection {
        case .categories:
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesCell", for: indexPath) as! CategoriesCarouselTableViewCell
            cell.configure(with: viewModel.categories)
            return cell
        case .topSellingProducts:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopSellingProductCell", for: indexPath) as! TopSellingProductTableViewCell
            cell.configure(withProduct: viewModel.topSellingProducts[indexPath.row], isLastIndex: indexPath.row == viewModel.topSellingProducts.count - 1)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let homeSection = viewModel.homeSections[section]
        switch homeSection {
        case .categories:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HomeTableHeaderView") as! HomeTableHeaderView
            header.headerLabel.text = "Categorias"
            return header
        case .topSellingProducts:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HomeTableHeaderView") as! HomeTableHeaderView
            header.headerLabel.text = "Mais Vendidos"
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let homeSection = viewModel.homeSections[indexPath.section]
        switch homeSection {
        case .categories:
            return 100
        default:
            return 100
        }
        
    }
    
}
