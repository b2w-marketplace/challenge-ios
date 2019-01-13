//
//  HomeTableViewController.swift
//  Lodjinha
//
//  Created by Lucas Gonçalves Serrano on 11/01/19.
//  Copyright © 2019 Lucas Gonçalves Serrano. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    private enum CellIdentifiers {
        static let banner = "BannerCell"
        static let category = "CategoriesCell"
        static let product = "ProductCell"
    }

    @IBOutlet weak var tableView: UITableView!

    var viewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let request = NetworkService(withBaseURL: Constants.BaseUrl)
        viewModel = HomeViewModel(request: request, delegate: self)

        tableView.separatorColor = .Greyish
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .WhiteTwo

        title = Constants.Home
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logoNavbar").resized(nil, 38))

        viewModel.fetchBanners()
        viewModel.fetchCategories()
        viewModel.fetchBestSellers()

        tableView.contentInset = UIEdgeInsets(top: -1, left: 0, bottom: 0, right: 0)
        tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.selectedCategory(notification:)),
                                               name: .init(rawValue: "clickedCategory"),
                                               object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func selectedCategory(notification: Notification) {
        if let category = notification.userInfo?["category"] as? Category {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "ProductListSegue", sender: category)
            }
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProductInfoSegue" {
            if let viewController = segue.destination as? ProductInfoViewController,
                let productViewModel = sender as? ProductInfoViewModel {
                viewController.productInfoViewModel = productViewModel
                viewController.hidesBottomBarWhenPushed = true
            }
        } else if segue.identifier == "ProductListSegue" {
            if let viewController = segue.destination as? ProductListViewController,
                let category = sender as? Category {
                viewController.category = category
                viewController.hidesBottomBarWhenPushed = true
            }
        }
    }

}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        if indexPath.section == 2 {
            self.performSegue(withIdentifier: "ProductInfoSegue",
                              sender: ProductInfoViewModel(product: viewModel.bestSeller(at: indexPath.row)))
        }
    }
}

extension HomeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(for: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.banner, for: indexPath) as! BannerTableViewCell
            if viewModel.isFetchingBanner {
                cell.configure(with: nil)
            } else {
                 cell.configure(with: viewModel.banners)
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.category, for: indexPath) as! CategoryTableViewCell
            if viewModel.isFetchingCategories {
                cell.configure(with: nil)
            } else {
                cell.configure(with: viewModel.categories)
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.product, for: indexPath) as! ProductTableViewCell
            if viewModel.isFetchingProducts {
                cell.configure(with: nil)
            } else {
                cell.configure(with: viewModel.bestSeller(at: indexPath.row))
            }
            return cell
        }

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.getHeight(for: indexPath.section)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let title = viewModel.getHeader(for: section) else {
            return UIView(frame: .zero)
        }
        let backgroundView = UIView()
        backgroundView.backgroundColor = .WhiteTwo
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = Font(.installed(.RobotoBold), size: .standard(.descriptionLarge)).instance
        titleLabel.textColor = .Dark
        titleLabel.text = title
        backgroundView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 15.0),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: 5.0),
            titleLabel.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor, constant: 2.0)
            ])
        return backgroundView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 1.0 : 44
    }
}

extension HomeViewController: HomeViewModelDelegate {

    func onBannersFetchCompleted() {
        tableView.reloadSections(IndexSet([0]), with: .automatic)
    }

    func onBannersFetchFailed() {

    }

    func onCategoriesFetchCompleted() {
        tableView.reloadSections(IndexSet([1]), with: .automatic)
    }

    func onCategoriesFetchFailed() {

    }

    func onBestSellersFetchCompleted() {
        tableView.reloadSections(IndexSet([2]), with: .automatic)
    }

    func onBestSellersFetchFailed() {

    }
}
