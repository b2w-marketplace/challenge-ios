//
//  CategoryProductsListViewController.swift
//  Lodjinha
//
//  Created by Douglas da Silva Santos on 28/03/19.
//  Copyright © 2019 Douglas da Silva Santos. All rights reserved.
//

import UIKit

class CategoryProductsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: CategoryProductsListViewModelType!
    var configurator: CategoryProductsListConfiguratorProtocol!
    
    convenience init() {
        self.init(nibName: String(describing: CategoryProductsListViewController.self), bundle: Bundle.main)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white];
        configurator.configure(viewController: self)
        
        configTableView()
        viewModel.loadProducts()
    }

    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: ProductTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: ProductTableViewCell.identifier)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        tableView.backgroundView = tableViewBackgroundView()
        tableView.tableFooterView = tableFooterViewLoadIndicator()
        tableView.tableFooterView?.isHidden = true
    }
    
    private func tableViewBackgroundView() -> UIView {
        let reloadButton = UIButton(type: UIButton.ButtonType.custom)
        let buttonTitle = viewModel.hasError ? "Tentar novamente" : "Nenhum produto encontrado"
        reloadButton.setTitle(buttonTitle, for: UIControl.State.normal)
        reloadButton.titleLabel?.numberOfLines = 0
        reloadButton.titleLabel?.textAlignment = .center
        reloadButton.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        reloadButton.addTarget(self, action: #selector(reloadInfo), for: UIControl.Event.touchUpInside)
        let backView = UIView(frame: tableView.frame)
        reloadButton.frame = CGRect(x: 0, y: 0, width: backView.frame.width / 2, height: 44)
        reloadButton.center = backView.center
        backView.addSubview(reloadButton)
        return backView
    }
    
    private func tableFooterViewLoadIndicator() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.startAnimating()
        indicator.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)

        return indicator
    }
    
    @objc private func reloadInfo() {
        viewModel.loadProducts()
    }
    
}

extension CategoryProductsListViewController: CategoryProductsListServicesDelegate {
    
    func receivedMoreData() {
        tableView.tableFooterView?.isHidden = true
        tableView.reloadData()
    }
    
    func loadingData(loading: Bool) {
        tableView.isHidden = loading
        tableView.tableHeaderView?.isHidden = !loading
        loading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
}

extension CategoryProductsListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        tableView.backgroundView?.isHidden = viewModel.numberOfSections != 0
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as! ProductTableViewCell
        cell.configure(withProduct: viewModel.products[indexPath.row], isLastIndex: indexPath.row == viewModel.products.count - 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfRowsInSection(section: indexPath.section) - 1 {
            if !viewModel.isLoadingData && !viewModel.noMoreData {
                tableView.tableFooterView?.isHidden = false
                viewModel.loadMore()
            }
        }
        tableView.tableHeaderView?.isHidden = true
    }
}
