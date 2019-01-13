//
//  CategoryViewController.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 07/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import UIKit

class CategoryViewController: AbstractViewController<CategoryViewModel>, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var footerView: UIView = {
        let footerFrame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30)
        let fView = UIView(frame: footerFrame)
        return fView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setuping views
        setupAccessibilities()
        setupNavigationBar()
        setupTableView()
        
        //setuping view model delegate
        vm.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        return vm.didSelectIndex(indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        vm.scrollViewDidScroll(scrollView)
    }
}

//MARK: Private methods
extension CategoryViewController {
    
    final fileprivate func setupAccessibilities() {
        view.accessibilityIdentifier = "CategoryViewController"
    }
    
    final fileprivate func setupNavigationBar() {
        title = vm.getCategoryName()
    }
    
    final fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.separatorInset = .zero
        tableView.tableFooterView = footerView
        
        tableView.refreshControlHandler { [weak self] (refreshControl) in
            self?.vm.didPullRefresh()
        }
        
        registerCells()
    }
    
    final fileprivate func registerCells() {
        tableView.registerCell(ProductListTableViewCell.self)
    }
}

//MARK: CategoryViewModel Delegate
extension CategoryViewController: CategoryViewModelDelegate {
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func onError(feedback message: String) {
        showSimpleAlertWith(title: nil, description: message, confirmAction: nil)
    }
    
    func loader(isShow: Bool, type: LoaderType) {
        if isShow {
            switch type {
            case .view:
                Loading.shared.showLoading()
            case .refreshControl:
                if #available(iOS 10.0, *) {
                    DispatchQueue.main.async { [weak self] in
                        self?.tableView.refreshControl?.beginRefreshing()
                    }
                } else {
                    guard let refreshControl = tableView.subviews.filter({ $0 is UIRefreshControl }).first as? UIRefreshControl else {
                        return
                    }
                    DispatchQueue.main.async {
                        refreshControl.beginRefreshing()
                    }
                }
            case .footerTableView:
                DispatchQueue.main.async { [weak self] in
                    self?.footerView.startLoading(showLabel: false)
                }
            }
        } else {
            switch type {
            case .view:
                Loading.shared.hideLoading()
            case .refreshControl:
                if #available(iOS 10.0, *) {
                    DispatchQueue.main.async { [weak self] in
                        self?.tableView.refreshControl?.endRefreshing()
                    }
                } else {
                    guard let refreshControl = tableView.subviews.filter({ $0 is UIRefreshControl }).first as? UIRefreshControl else {
                        return
                    }
                    DispatchQueue.main.async {
                        refreshControl.endRefreshing()
                    }
                }
            case .footerTableView:
                DispatchQueue.main.async { [weak self] in
                    self?.footerView.stopLoading()
                }
            }
        }
    }
    
    func pushNavigationTo(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
