//
//  ProductsViewController.swift
//  Challange-iOS
//
//  Created by Maria Eugênia Teixeira on 20/01/19.
//  Copyright © 2019 Maria Eugênia Teixeira. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ProductsViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = ProductsViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true

        tableView.delegate = self
        
        viewModel.getProducts()
        bindTableView()
        
    }

    func bindTableView() {
        
        viewModel.products.asObservable().bind { (value) in
            if value.count > 0 { self.navigationController?.navigationItem.title = value[0].categoria?.descricao ?? "" }
            self.tableView.reloadData()
            }.disposed(by: disposeBag)
        
        viewModel.products
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: IndexPath(row: row, section: 0)) as? MostSoldTableViewCell else { return UITableViewCell() }
                cell.configureCell(mostSold: element)
                return cell
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(Products.self)
            .subscribe(onNext:  { value in
                if let productId = value.id {
                    self.callProductDetailViewController(withProductID: productId)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func callProductDetailViewController(withProductID productID: Int) {
        let storyboard = UIStoryboard(storyboard: .main)
        let viewController: ProductDetailViewController = storyboard.instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
        viewController.productID = productID
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}
