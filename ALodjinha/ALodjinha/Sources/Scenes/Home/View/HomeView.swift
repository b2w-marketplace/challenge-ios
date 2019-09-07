//
//  HomeView.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 05/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit

class HomeView: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    private lazy var viewModel: HomeViewModel = HomeViewModel(delegate: self)
    weak var delegate: HomeViewDelegate?
    
    //MARK: - Cycle life UIView
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - Private Methods
    private func setupView() {
        viewModel.loadBanner()
        viewModel.loadCategories()
        viewModel.loadBestSeller()
        tableView.dataSource = self
        tableView.delegate = self
        registerCells()
        setupNavBar()
        setupNavigationItemImage()
    }
    
    private func registerCells() {
        let bannerNibName = UINib(nibName: BannerString.BannerTableViewCell, bundle: nil)
        tableView.register(bannerNibName, forCellReuseIdentifier: BannerString.BannerCell)
        let categoriesNibName = UINib(nibName: CategorriesString.CategoriesTableViewCell, bundle: nil)
        tableView.register(categoriesNibName, forCellReuseIdentifier: CategorriesString.CategoriesCell)
        let productNibName = UINib(nibName: ProductString.ProductTableViewCell, bundle: nil)
        tableView.register(productNibName, forCellReuseIdentifier: ProductString.ProductCell)
    }
    
    //MARK: - NavigationBar
    func setupNavigationItemImage() {
        let logoContainer = UIView(frame: CGRect(x: 0,
                                                 y: 0,
                                                 width: 200,
                                                 height: 30))
        let imageView = UIImageView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 200,
                                                  height: 30))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "logoNavbar")
        logoContainer.addSubview(imageView)
        self.navigationItem.titleView = logoContainer
    }
    
    private func setupNavBar() {
        self.navigationController?.navigationBar.isTranslucent = false
        let nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(red: 86.0/255.0,
                                    green: 41.0/255.0,
                                    blue: 126.0/255.0,
                                    alpha: 1.0)
        nav?.tintColor = .white
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        setNeedsStatusBarAppearanceUpdate()
    }
}

//MARK: - LoadContentable implements
extension HomeView: LoadContentable {
    func didLoad() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: - UITableViewDataSource implements
extension HomeView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeader(section: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BannerString.BannerCell, for: indexPath) as? BannerTableViewCell else {
                return BannerTableViewCell()
            }
            cell.delegate?.fetchBanner(banner: viewModel.banners)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategorriesString.CategoriesCell, for: indexPath) as? CategoriesTableViewCell else {
                return CategoriesTableViewCell()
            }
            cell.delegate?.fetchCategory(category: viewModel.category)
            cell.homeViewDelegate = self
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductString.ProductCell, for: indexPath) as? ProductTableViewCell else {
                return ProductTableViewCell()
            }
            cell.fill(dto: viewModel.dtoForRows(indexPath: indexPath))
            return cell
        }
    }
}

extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.fetchProduct(product: viewModel.productTransporter(indexPath: indexPath))
    }
}

extension HomeView: HomeViewDelegate {
    func displayProduct(category: Category) {
        delegate?.displayProduct(category: category)
    }
    func fetchProduct(product: Product) {}
}
