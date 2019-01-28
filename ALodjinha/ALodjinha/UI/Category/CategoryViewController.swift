//
//  CategoryViewController.swift
//  ALodjinha
//
//  Created by Vinicius Andrade on 27/01/19.
//  Copyright © 2019 Vinicius Andrade. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import PKHUD

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var productTableView: UITableView!
    var viewModel = CategoryViewModel()
    var disposeBag = DisposeBag()
    @IBOutlet weak var emptyTextLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRx()
        setupNavigation()
        
        HUD.show(.progress)
    }
    
    func setupRx() {
        viewModel.productArray.bind(to: productTableView.rx.items(cellIdentifier: "Product", cellType: ProductTableViewCell.self)) { (row, element, cell) in
            cell.setup(model: element)
            }.disposed(by: disposeBag)
        
        viewModel.productArray.skip(1).asObservable().subscribe(onNext: { [weak self] (productArray) in
            HUD.hide()
            if productArray.count == 0 {
                self?.activityIndicator.isHidden = true
                self?.productTableView.isHidden = true
                self?.emptyTextLabel.isHidden = false
            } else {
                self?.productTableView.isHidden = false
                self?.emptyTextLabel.isHidden = true
                if productArray.count % 20 == 0 {
                    self?.activityIndicator.isHidden = false
                } else {
                    self?.activityIndicator.isHidden = true
                }
            }
        }).disposed(by: disposeBag)
        
        viewModel.lastPage.asObservable().subscribe(onNext: { (lastPage) in
            if lastPage {
                self.activityIndicator.isHidden = true
            }
        }).disposed(by: disposeBag)
        
        productTableView.rx_reachedBottom
            .throttle(2, scheduler: MainScheduler.instance)
            .map { _ in () }
            .bind(to: self.viewModel.loadNextPageTrigger)
            .disposed(by: disposeBag)
        
        productTableView.rx.modelSelected(ProductModel.self).subscribe(onNext: { [weak self] productSelected in
            self?.performSegue(withIdentifier: "showDetail", sender: productSelected)
        }).disposed(by: disposeBag)
        
    }
    
    func setupNavigation() {
        navigationItem.title = viewModel.category?.description
        let backButton = UIBarButtonItem()
        backButton.title = "Home"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let viewController = segue.destination as! ProductViewController
            viewController.viewModel.product.accept((sender as! ProductModel))
        }
    }

}
