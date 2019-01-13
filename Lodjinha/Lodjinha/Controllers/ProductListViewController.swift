//
//  ProductListViewController.swift
//  Lodjinha
//
//  Created by Lucas Gonçalves Serrano on 10/01/19.
//  Copyright © 2019 Lucas Gonçalves Serrano. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {
    private enum CellIdentifiers {
        static let list = "List"
    }

    @IBOutlet var indicatorView: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!

    var category: Category!

    private var viewModel: ProductListViewModel!

    private var shouldShowLoadingCell = false

    override func viewDidLoad() {
        super.viewDidLoad()

        indicatorView.color = .GreyishBrown
        indicatorView.startAnimating()

        tableView.isHidden = true
        tableView.separatorColor = .Greyish
        tableView.rowHeight = .init(100.0)
        tableView.dataSource = self
        tableView.delegate = self
        if #available(iOS 10.0, *) {
            tableView.prefetchDataSource = self
        }

        let request = NetworkService(withBaseURL: Constants.BaseUrl)
        viewModel = ProductListViewModel(request: request, delegate: self, categoryId: category.id)

        title = category.description

        viewModel.fetchProducts()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProductInfoSegue" {
            if let viewController = segue.destination as? ProductInfoViewController,
                let product = sender as? Product {
                viewController.productInfoViewModel = ProductInfoViewModel(product: product)
                viewController.hidesBottomBarWhenPushed = true
            }
        }
    }
}

extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.list, for: indexPath) as! ProductTableViewCell
        if isLoadingCell(for: indexPath) {
            cell.configure(with: .none)
        } else {
            cell.configure(with: viewModel.product(at: indexPath.row))
        }
        return cell
    }
}

extension ProductListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        self.performSegue(withIdentifier: "ProductInfoSegue", sender: viewModel.product(at: indexPath.row))
    }
}

extension ProductListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.fetchProducts()
        }
    }
}

extension ProductListViewController: ProductListViewModelDelegate {
    func didUpdateTotal() {
        self.tableView.reloadData()
    }

    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            indicatorView.stopAnimating()
            tableView.isHidden = false
            tableView.reloadData()
            return
        }
        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        tableView.reloadRows(at: indexPathsToReload, with: .automatic)
    }

    func onFetchFailed(with reason: String) {
        indicatorView.stopAnimating()
        displayOkMessage(text: "Erro ao buscar produtos")
    }
}

private extension ProductListViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.currentCount
    }

    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}
