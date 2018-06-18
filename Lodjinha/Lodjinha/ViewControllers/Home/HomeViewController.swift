//
//  HomeViewController.swift
//  Lodjinha
//
//  Created by Matheus Pacheco Fusco on 14/06/2018.
//  Copyright © 2018 Fusco. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: BaseViewController {

    //MARK: - Lets and Vars
    let viewModel: HomeViewModel = HomeViewModel()
    var banners: [Banner] = [Banner]()
    var categories: [Category] = [Category]()
    var products: [Product] = [Product]()
    var selectedCategory: Category?
    var selectedProduct: Product?
    
    //MARK: - IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var bannerActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        registerCells()
        getBanners()
        getCategories()
        getBestSellerProducts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNavigationBar()
    }
    
    //MARK: - Custom Methods
    func configureViews() {
        self.scrollView.delegate = self
        self.scrollView.dropShadow()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
    }
    
    func setNavigationBar() {
        let customNavigationview = UIView()
        let label = UILabel()
        label.text = "a Lodjinha"
        label.font = UIFont(name: "Pacifico-Regular", size: 20)
        label.textColor = UIColor.white
        label.sizeToFit()
        label.center = customNavigationview.center
        label.textAlignment = NSTextAlignment.center

        let logoImageView = UIImageView()
        logoImageView.image = (#imageLiteral(resourceName: "logoSobre"))
        logoImageView.frame = CGRect(x: label.frame.origin.x - 45, y: label.frame.origin.y, width: 40, height: label.frame.size.height)
        logoImageView.contentMode = .scaleAspectFit

        customNavigationview.addSubview(label)
        customNavigationview.addSubview(logoImageView)

        customNavigationview.sizeToFit()

        self.navigationItem.titleView = customNavigationview
    }
    
    func registerCells() {
        let nibProduct = UINib.init(nibName: "ProductTableViewCell", bundle: Bundle(for: type(of: self)))
        self.tableView.register(nibProduct, forCellReuseIdentifier: "productCell")
        
        let nibCategories = UINib.init(nibName: "CategoriesTableViewCell", bundle: Bundle(for: type(of: self)))
        self.tableView.register(nibCategories, forCellReuseIdentifier: "categoriesCell")
    }
    
    //MARK: Banner Methods
    func getBanners() {
        bannerActivityIndicator.startAnimating()
        viewModel.getBanners(success: { (banners) in
            self.bannerActivityIndicator.stopAnimating()
            self.banners = banners
            self.createBanners()
        }) { (error) in
            self.bannerActivityIndicator.stopAnimating()
            print(error)
        }
    }
    
    func createBanners() {
        self.pageControl.numberOfPages = self.banners.count
        
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        
        for i in 0...self.banners.count - 1 {
            let banner = self.banners[i]
            let img = UIImageView(frame: CGRect(x:scrollViewWidth * CGFloat(i), y: 0, width: scrollViewWidth, height: scrollViewHeight))
            img.kf.setImage(with: URL(string: "\(banner.urlImagem)"))
            self.scrollView.addSubview(img)
        }
        
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.width * CGFloat(self.banners.count),  height: self.scrollView.frame.height)
        self.pageControl.currentPage = 0
    }

    //MARK: Category Methods
    func getCategories() {
        viewModel.getCategories(success: { (categories) in
            self.categories = categories
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
    //MARK: Best Seller Methods
    func getBestSellerProducts() {
        viewModel.getBestSellerProducts(success: { (products) in
            self.products = products
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
    //MARK: - Memory Management
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.hidesBottomBarWhenPushed = true
        if let prodList = segue.destination as? ProductListViewController, let category = selectedCategory {
            prodList.category = category
        }
        else if let prodDetail = segue.destination as? ProductDetailViewController, let product = selectedProduct {
            prodDetail.product = product
        }
    }
 

}

//MARK: - ScrollView Delegate Methods
extension HomeViewController : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth: CGFloat = scrollView.frame.width
        let currentPage: CGFloat = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
        self.pageControl.currentPage = Int(currentPage)
    }
}

//MARK: - UITableView Delegate & DataSource Methods
protocol CellDelegate {
    func showProductsFromCategory(category: Category)
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource, CellDelegate {
    func showProductsFromCategory(category: Category) {
        self.selectedCategory = category
        self.performSegue(withIdentifier: "showProductsFromCategoryIdentifier", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesCell", for: indexPath) as! CategoriesTableViewCell
            cell.categories = self.categories
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductTableViewCell
            cell.product = products[indexPath.row]
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
                return 1
            case 1:
                return products.count
            default:
                return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        view.backgroundColor = .groupTableViewBackground
        label.frame = CGRect(x: 16, y: 0, width: tableView.frame.size.width, height: 28)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        switch section {
            case 0:
                label.text = "Categorias"
            case 1:
                label.text = "Mais vendidos"
            default:
                label.text = ""
        }
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
            case 1:
                self.selectedProduct = self.products[indexPath.row]
                self.performSegue(withIdentifier: "showProductDetailIdentifier", sender: self)
            default:
                tableView.deselectRow(at: indexPath, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            case 0:
                return 110
            case 1:
                return 91
            default:
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            case 0:
                return 110
            case 1:
                return 91
            default:
                return 0
        }
    }
}
