//
//  HomeViewController.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 07/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import UIKit

class HomeViewController: AbstractViewController<HomeViewModel>, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var titleImageView: UIImageView = {
        let image: UIImage? = UIImage(named: "logoNavbar")
        let imageView: UIImageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 125, height: 35)
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // setuping views
        setupAccessibilities()
        setupNavigationBar()
        setupTableView()
        
        // setuping view model delegate
        vm.delegate = self
        
        // loading data
        vm.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: UITableView DataSource & Delegate
    
    // DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return vm.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.getNumberOfRowsIn(section: section)
    }
  
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       return vm.getHeaderViewFor(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return vm.getHeaderHeightFor(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return vm.getCellFor(table: tableView, index: indexPath)
    }
    
    // Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        return vm.didSelectIndex(indexPath)
    }
}

//MARK: Private methods
extension HomeViewController {
    
    final fileprivate func setupAccessibilities() {
        view.accessibilityIdentifier = "HomeViewController"
        tableView.accessibilityIdentifier = "HomeTableView"
    }
    
    final fileprivate func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.titleView = titleImageView
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home",
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
    }
    
    final fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.separatorInset = .zero
        
        tableView.refreshControlHandler { [weak self] (refreshControl) in
            self?.vm.didPullRefresh()
        }
        
        registerCells()
    }
    
    final fileprivate func registerCells() {
        tableView.registerCell(BannerTableViewCell.self)
        tableView.registerCell(CategoryTableViewCell.self)
        tableView.registerCell(ProductListTableViewCell.self)
    }
}

//MARK: HomeViewModel Delegate
extension HomeViewController: HomeViewModelDelegate {
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
            default:
                break
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
            default:
                break
            }
        }
    }
    
    func pushNavigationTo(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
