//
//  ViewController.swift
//  Lodjinha
//
//  Created by Marcos on 17/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var presenter: HomePresenterProtocol!
    
    private var datasource: [[String: Array<Any>]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccessibilityIdentifiers()
        applyLanguage()
        setupTableView()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        applyStyle()
    }
    
    // MARK: - Setup Methods
    private func setupAccessibilityIdentifiers() {
        
    }
    
    private func applyLanguage() {
        
    }
    
    private func applyStyle() {
        Style.apply(onNavigationBarWithImageTitle: navigationItem)
    }

    private func setupTableView() {
        //tableView.register(cellType: MessagePopupCell.self)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 24
        tableView.bounces = false
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
}

// MARK: - HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
    
    func setup(bannerList: [Banner]) {
        datasource.append(["banners": bannerList])
        tableView.reloadData()
    }
    
    func setup(categoryList: [Category]) {
        datasource.append(["categories": categoryList])
        tableView.reloadData()
    }
    
    func setup(topSellingProductList: [Product]) {
        datasource.append(["products": topSellingProductList])
        tableView.reloadData()
    }
    
    func showAlert(message: String) {
        presentAlert(message: message)
    }
    
}

