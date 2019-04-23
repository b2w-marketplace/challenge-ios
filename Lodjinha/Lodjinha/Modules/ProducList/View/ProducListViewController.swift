//
//  ProducListViewController.swift
//  Lodjinha
//
//  Created on 22/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit
import CCBottomRefreshControl
import NVActivityIndicatorView

final class ProducListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    @IBOutlet private weak var labelEmptyState: UILabel!
    
    @IBOutlet private weak var activityIndicatorContainerView: UIView!
    
    @IBOutlet private weak var activityIndicatorView: NVActivityIndicatorView!
    
    var presenter: ProducListPresenterProtocol!
    
    private var bottomRefreshControl = UIRefreshControl()
    private var productList: [Product] = []
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccessibilityIdentifiers()
        applyLanguage()
        applyStyle()
        setupInfinitScroll()
        setupTableView()
        setupTabBar()
        
        presenter.viewDidLoad()
    }
    
    // MARK: - Setup Methods
    private func setupAccessibilityIdentifiers() {
        tableView.accessibilityIdentifier = "tableView"
        
        labelEmptyState.accessibilityIdentifier = "labelEmptyState"
        
        activityIndicatorContainerView.accessibilityIdentifier = "activityIndicatorContainerView"
        
        activityIndicatorView.accessibilityIdentifier = "activityIndicatorView"
    }
    
    private func applyLanguage() {
        title = presenter.title
        navigationController?.addBackButton(title: String(identifier: .home))
        labelEmptyState.text = String(identifier: .emptyStateCategory)
    }
    
    private func applyStyle() {
        activityIndicatorView.type = .ballRotateChase
        activityIndicatorView.color = Palette.Purple.main.color
        
        Style.text(font: UIFont.systemFont(ofSize: 14),
                   color: Palette.Gray.main.color,
                   alignment: .center)
            .apply(on: labelEmptyState)
    }
    
    private func setupInfinitScroll() {
        let bottomRefreshControl = UIRefreshControl()
        bottomRefreshControl.addTarget(self, action: #selector(loadMore), for: .valueChanged)
        self.bottomRefreshControl = bottomRefreshControl
        tableView.bottomRefreshControl = bottomRefreshControl
    }
    
    private func setupTableView() {
        tableView.register(cellType: ProductCell.self)
        tableView.registerForHeaderFooter(headerFooterType: HomeTableHeaderView.self)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 1
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupTabBar() {
        tabBarController?.tabBar.isHidden = true
    }
    
    @objc private func loadMore() {
        let currentFilter = presenter.currentFilter
        currentFilter.offset = presenter.numberOfProducts
        presenter.fetchProducts(withFilter: currentFilter)
    }

}

// MARK: - UITableViewDataSource
extension ProducListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfProducts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductCell = tableView.dequeueReusableCell(for: indexPath)
        let product = presenter.product(at: indexPath.row)
        cell.setup(product: product)
        return cell
    }
    
}


// MARK: - UITableViewDelegate
extension ProducListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectProduct(at: indexPath.row)
    }
    
}

// MARK: - ProducListViewProtocol
extension ProducListViewController: ProducListViewProtocol {
    
    func updateView() {
        tableView.reloadData()
        bottomRefreshControl.endRefreshing()
    }
    
    func showAlert(message: String) {
        presentAlert(message: message)
    }
    
    func showEmptyState() {
        labelEmptyState.isHidden = false
    }
    
    func hideEmptyState() {
        labelEmptyState.isHidden = true
    }
    
    func showActiveIndicator() {
        activityIndicatorContainerView.isHidden = false
        activityIndicatorView.startAnimating()
    }
    
    func hideActiveIndicator() {
        activityIndicatorContainerView.isHidden = true
        activityIndicatorView.stopAnimating()
    }

}

