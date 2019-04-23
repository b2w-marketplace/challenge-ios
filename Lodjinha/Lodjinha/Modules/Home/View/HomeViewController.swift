//
//  ViewController.swift
//  Lodjinha
//
//  Created by Marcos on 17/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var presenter: HomePresenterProtocol!
    
    private var bannerList: [Banner] = []
    private var categoryList: [Category] = []
    private var topSellingProductList: [Product] = []
    
    private var activityIndicator: NVActivityIndicatorView {
        return NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 120, height: 120),
                                       type: NVActivityIndicatorType.ballBeat,
                                       color: Palette.Purple.main.color)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccessibilityIdentifiers()
        applyStyle()
        setupTableView()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        setupTabBar()
        applyStyle()
    }
    
    // MARK: - Setup Methods
    private func setupAccessibilityIdentifiers() {
        tableView.accessibilityIdentifier = "tableView"
    }
    
    private func applyStyle() {
        Style.apply(onNavigationBarWithImageTitle: navigationItem)
    }

    private func setupTableView() {
        tableView.register(cellType: BannerCell.self)
        tableView.register(cellType: ProductCell.self)
        tableView.register(cellType: CategoriesCell.self)
        tableView.registerForHeaderFooter(headerFooterType: HomeTableHeaderView.self)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 24
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupTabBar() {
        tabBarController?.tabBar.isHidden = false
    }
    
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return topSellingProductList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell: BannerCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(bannerList: bannerList)
            return cell
        case 1:
            let cell: CategoriesCell = tableView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            cell.setup(categoryList: categoryList)
            return cell
        default:
            let cell: ProductCell = tableView.dequeueReusableCell(for: indexPath)
            let product = topSellingProductList[indexPath.row]
            cell.setup(product: product)
            return cell
        }
    }
    
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: HomeTableHeaderView = tableView.dequeueReusableHeaderFooterView()
        switch section {
        case 0:
            headerView.setup(title: String())
        case 1:
            headerView.setup(title: String(identifier: .categories))
        default:
            headerView.setup(title: String(identifier: .topSelling))
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0.0
        default:
            return 36.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let product = topSellingProductList[indexPath.row]
            presenter.didSelectProduct(product: product)
        }
    }
    
}

// MARK: - CategoriesCellDelegate
extension HomeViewController: CategoriesCellDelegate {
    
    func categoriesCell(cell: CategoriesCell, didSelectItemAt indexPath: IndexPath) {
        let category = categoryList[indexPath.row]
        presenter.didSelectCategory(category: category)
    }

}

// MARK: - HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
    
    func setup(bannerList: [Banner]) {
        self.bannerList = bannerList
        tableView.reloadData()
    }
    
    func setup(categoryList: [Category]) {
        self.categoryList = categoryList
        tableView.reloadData()
    }
    
    func setup(topSellingProductList: [Product]) {
        self.topSellingProductList = topSellingProductList
        tableView.reloadData()
    }
    
    func showAlert(message: String) {
        presentAlert(message: message)
    }
    
    func showActiveIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideActiveIndicator() {
        activityIndicator.stopAnimating()
    }
    
}

