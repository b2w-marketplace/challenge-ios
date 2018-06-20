//
//  HomeViewController.swift
//  Lodjinha
//
//  Created by André Assis on 15/06/18.
//  Copyright © 2018 André Assis. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: BaseViewController, HomeBannerDelegate, CategoriesTableCellDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var bannerCollection: HomeBannerCollection!
    @IBOutlet weak var tableView: UITableView!
    
    

    var client: APIClient!
    
    private var disposeBag = DisposeBag()
    
    private var categories: [CategoryModel]?
    private var bestSellerProducts: [ProductModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLoadingCover()

        bannerCollection.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsetsMake(-30.0, 0.0, 0.0, 0.0)
        tableView.register(TableHeader.headerNib(), forHeaderFooterViewReuseIdentifier: "header")
        
        loadingView.setCallback { [weak self] in
            self?.loadAll()
        }
        
        loadAll()
    }
    
    private func loadAll() {
        Observable.zip(client.lodjinhaProvider.moyaRequest(.getBanner, type: BannerResponseModel.self),
                       client.lodjinhaProvider.moyaRequest(.getCategories, type: CategoryResponseModel.self),
                       client.lodjinhaProvider.moyaRequest(.getBestSellers, type: ProductResponseModel.self)).subscribe(onNext: { [weak self] (bannerResponse, categoryResponse, productResponse) in
                if let s = self {
                    s.bannerCollection.banners = bannerResponse.banners
                    s.categories = categoryResponse.categories
                    s.bestSellerProducts = productResponse.products
                    s.loadingView.hide()
                    s.tableView.reloadData()
                }
            }, onError: { [weak self] (error) in
                if let s = self {
                    s.loadingView.displayError()
                }
            }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Home"
        setCustomTitle()
    }
    
    private func setCustomTitle() {
        let imgView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 120, height: 40))
        imgView.contentMode = .scaleAspectFit
        imgView.image = #imageLiteral(resourceName: "logoNavbar")
        self.navigationItem.titleView = imgView
    }
    
    // MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return bestSellerProducts?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header: TableHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? TableHeader {
            
            let title = section == 0 ? "Categorias" : "Mais Vendidos"
            
            header.setupWithTitle(title)
            return header
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0, let cat = categories,
            let cell: CategoriesTableCell = tableView.dequeueReusableCell(withIdentifier: "categoriesCell", for: indexPath) as? CategoriesTableCell {
            cell.setupWithCategories(cat)
            cell.delegate = self
            return cell
        } else if indexPath.section == 1, let product = bestSellerProducts?.itemFor(index: indexPath),
            let cell: ProductTableViewCell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as? ProductTableViewCell {
            cell.setupWithProduct(product)
            cell.tintColor = UIColor.appPurple()
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1, let product = bestSellerProducts?.itemFor(index: indexPath) {
            let vc = ProductDetailViewController.instantiate()
            vc.productId = product.id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - HomeBannerDelegate
    
    func selectBanner(_ banner: BannerModel) {
        if let url = URL.init(string: banner.linkUrl) {
            UIApplication.shared.openURL(url)
        }
    }
    
    // MARK: - CategoriesDelegate
    
    func selectedCategory(_ category: CategoryModel) {
        let vc = CategoryViewController.instantiate()
        vc.category = category
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
