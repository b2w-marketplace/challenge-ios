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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: HomeViewModelType!
    var configurator: HomeConfiguratorProtocol!
    
    convenience init() {
        self.init(nibName: String(describing: HomeViewController.self), bundle: Bundle.main)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(viewController: self)
        configTableView()
        
        viewModel.loadHome()
    }
    
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CategoriesCarouselTableViewCell.self, forCellReuseIdentifier: CategoriesCarouselTableViewCell.identifier)
        tableView.register(UINib(nibName: ProductTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: ProductTableViewCell.identifier)
        tableView.register(UINib(nibName: HomeTableHeaderView.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: HomeTableHeaderView.identifier)
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        tableView.backgroundView = tableViewBackgroundView()
        configNavBarLogo()
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
    
    @objc private func reloadInfo() {
        viewModel.loadHome()
    }
    
    private func configNavBarLogo() {
        let image = UIImage(named: "logoNavbar")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width / 2, height: 28))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
}

extension HomeViewController: HomeServicesDelegate {
 
    func finishLoadingHome() {
        bannersView.updateBanners(banners: viewModel.banners)
        tableView.reloadData()
    }
    
    func loadingData(loading: Bool) {
        tableView.isHidden = loading
        loading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableView.backgroundView?.isHidden = viewModel.numberOfSections != 0
        tableView.tableHeaderView?.isHidden = viewModel.numberOfSections == 0
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: viewModel.homeSections[section])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeSection = viewModel.homeSections[indexPath.section]
        switch homeSection {
        case .categories:
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesCarouselTableViewCell.identifier, for: indexPath) as! CategoriesCarouselTableViewCell
            cell.delegate = self
            cell.configure(with: viewModel.categories)
            return cell
        case .topSellingProducts:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as! ProductTableViewCell
            cell.configure(withProduct: viewModel.topSellingProducts[indexPath.row], isLastIndex: indexPath.row == viewModel.topSellingProducts.count - 1)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let homeSection = viewModel.homeSections[section]
        switch homeSection {
        case .categories:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeTableHeaderView.identifier) as! HomeTableHeaderView
            header.headerLabel.text = "Categorias"
            return header
        case .topSellingProducts:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeTableHeaderView.identifier) as! HomeTableHeaderView
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 { return }
        
        viewModel.select(product: viewModel.topSellingProducts[indexPath.row])
    }
    
}

extension HomeViewController: CategoriesCarouselDelegate {
    func categoriesCarousel(carousel: CategoriesCarouselTableViewCell, didTapCategory category: ProductCategory, atIndex index: IndexPath) {
        
        viewModel.select(category: category)
    }
}
