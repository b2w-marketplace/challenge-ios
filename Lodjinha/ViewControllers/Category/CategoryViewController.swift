//
//  CategoryViewController.swift
//  Lodjinha
//
//  Created by André Assis on 15/06/18.
//  Copyright © 2018 André Assis. All rights reserved.
//

import UIKit
import RxSwift

class CategoryViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var category: CategoryModel!
    
    var client: APIClient!
    
    private var products: [ProductModel] = []
    private var offset: Int = 0
    private let limit: Int = 20
    private var hasMore: Bool = false
    
    private var subscriptionProducts: Disposable?
    
    class func instantiate() -> CategoryViewController {
        return UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "categoryProducts") as! CategoryViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = category.description
        
        setLoadingCover()
        
        loadingView.setCallback { [weak self] in
            self?.loadProducts()
        }
        
        loadProducts()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func loadProducts() {
        subscriptionProducts?.dispose()
        
        subscriptionProducts = client.lodjinhaProvider.moyaRequest(.getProductsForCategory(categoryId: category.id, offset: offset, limit: limit), type: OffsetProductResponseModel.self).subscribe(onNext: { [weak self] (response) in
            if let s = self {
                s.products.append(contentsOf: response.products)
                s.offset = response.offset
                s.hasMore = response.offset < response.total
                s.loadingView.hide()
                s.tableView.reloadData()
            }
        }, onError: { [weak self] (error) in
            if let s = self {
                s.loadingView.displayError()
            }
        })
    }
    
    // MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count == 0 ? 0 : products.count + (hasMore ? 1 : 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let product = products.itemFor(index: indexPath),
            let cell: ProductTableViewCell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as? ProductTableViewCell {
            cell.setupWithProduct(product)
            cell.tintColor = UIColor.appPurple()
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        
        if hasMore {
            loadProducts()
        }

        return tableView.dequeueReusableCell(withIdentifier: "loading", for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let product = products.itemFor(index: indexPath) {
            let vc = ProductDetailViewController.instantiate()
            vc.productId = product.id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
