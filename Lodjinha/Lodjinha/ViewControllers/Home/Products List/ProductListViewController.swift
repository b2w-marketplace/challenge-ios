//
//  ProductListViewController.swift
//  Lodjinha
//
//  Created by Matheus Pacheco Fusco on 15/06/2018.
//  Copyright © 2018 Fusco. All rights reserved.
//

import UIKit

class ProductListViewController: BaseViewController {

    //MARK: - Lets and Vars
    let viewModel: ProductListViewModel = ProductListViewModel()
    var category: Category? {
        didSet {
            self.title = category?.descricao
        }
    }
    var products: [Product] = [Product]()
    var selectedProduct: Product?
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        registerCells()
        getProducts()
    }
    
    //MARK: - Custom Methods
    func configureView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
    }
    
    func registerCells() {
        let nibProduct = UINib.init(nibName: "ProductTableViewCell", bundle: Bundle(for: type(of: self)))
        self.tableView.register(nibProduct, forCellReuseIdentifier: "productCell")
    }
    
    func getProducts() {
        viewModel.getProductsFromCategory(category: category!, success: { (products) in
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
        if let prodDetail = segue.destination as? ProductDetailViewController, let product = selectedProduct {
            prodDetail.product = product
        }
    }
}

//MARK: - UITableView Delegate & DataSource Methods
extension ProductListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductTableViewCell
        cell.product = products[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if products.count == 0 {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "Não há produtos disponíveis para a categoria \((category?.descricao)!)"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            noDataLabel.numberOfLines = 0
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return products.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 91
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 91
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedProduct = products[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "showProductDetailIdentifier", sender: self)
    }
}
