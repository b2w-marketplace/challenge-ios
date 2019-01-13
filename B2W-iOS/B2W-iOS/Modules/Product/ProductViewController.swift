//
//  ProductViewController.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 07/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import UIKit

class ProductViewController: AbstractViewController<ProductViewModel>, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var reserveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setuping views
        setupAccessibilities()
        setupNavigationBar()
        setupTableView()
        setupButtons()
        
        // delegate
        vm.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: Actions
    @IBAction func reserveButtonPressed(_ sender: Any) {
        vm.didReserveProduct()
    }
    
    //MARK: UITableView DataSource & Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return vm.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.getNumberOfRowsIn(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return vm.getCellFor(table: tableView, index: indexPath)
    }
}

//MARK: Private methods
extension ProductViewController {
    
    final fileprivate func setupAccessibilities() {
        view.accessibilityIdentifier = "ProductViewController"
        reserveButton.isAccessibilityElement = true
        reserveButton.accessibilityIdentifier = "ProductViewController.ReserveBtn"
    }
    
    final fileprivate func setupNavigationBar() {
        title = vm.getProductName()
    }
    
    final fileprivate func setupButtons() {
        reserveButton.layer.cornerRadius = 6.0
        reserveButton.layer.masksToBounds = true
        reserveButton.setTitle("Reservar", for: UIControl.State())
    }
    
    final fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.separatorInset = .zero
        tableView.allowsSelection = false
        
        registerCells()
    }
    
    final fileprivate func registerCells() {
        tableView.registerCell(ProductTableViewCell.self)
        tableView.registerCell(PriceTableViewCell.self)
        tableView.registerCell(SimpleTitleAndTextTableViewCell.self)
    }
}

//MARK: ProductViewModel Delegate
extension ProductViewController: ProductViewModelDelegate {
    func onSuccessWith(feedback message: String) {
        showSimpleAlertWith(title: nil,
                            description: message,
                            confirmAction: { [weak self] in
            self?.vm.didConfirmSuccess()
        })
    }
    
    func onError(feedback message: String) {
        showSimpleAlertWith(title: nil, description: message, confirmAction: nil)
    }
    
    func loader(isShow: Bool, type: LoaderType) {
        if isShow {
            switch type {
            case .view:
                Loading.shared.showLoading()
            default:
                break
            }
        } else {
            switch type {
            case .view:
                Loading.shared.hideLoading()
            default:
                break
            }
        }
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}
