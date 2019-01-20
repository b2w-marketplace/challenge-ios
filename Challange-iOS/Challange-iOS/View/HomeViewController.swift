//
//  ViewController.swift
//  Challange-iOS
//
//  Created by Maria Eugênia Teixeira on 19/01/19.
//  Copyright © 2019 Maria Eugênia Teixeira. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class HomeViewController: UIViewController, UICollectionViewDelegate, UITableViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        collectionView.delegate = self
        tableView.delegate = self
        setupNavigation()
        viewModel.getBanners()
        viewModel.getCategories()
        viewModel.getMostSold()
        callBacks()
        bindCollectionView()
        bindTableView()
        
    }

    func setupNavigation() {
        self.navigationItem.titleView = self.setupNavigationView()
    }
    
    func callBacks() {
        
        viewModel.banners.asObservable()
            .bind { (_) in
                self.setupSlideScrollView(banner: self.viewModel.createImageViewBanner(width: self.view.frame.width))
            }.disposed(by: disposeBag)
        
    }
    
    func setupSlideScrollView(banner: [BannerView]) {
        
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(banner.count), height: 160)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< banner.count {
            banner[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: 160)
            scrollView.addSubview(banner[i])
        }
    }
    
    func bindCollectionView() {
        
        viewModel.categories.asObservable().bind { (_) in
            self.collectionView.reloadData()
            }.disposed(by: disposeBag)

        viewModel.categories
            .bind(to: collectionView.rx.items(cellIdentifier: "CATEGORY_CELL", cellType: CategoryCollectionViewCell.self)) { (row, element, cell) in
                cell.configureCell(category: element)
            }
            .disposed(by: disposeBag)

        collectionView.rx
            .modelSelected(Category.self)
            .subscribe(onNext:  { value in

            })
            .disposed(by: disposeBag)
    }
    
    func bindTableView() {
        
        viewModel.mostSold.asObservable().bind { (_) in
            self.tableView.reloadData()
            }.disposed(by: disposeBag)
        
        viewModel.mostSold
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: IndexPath(row: row, section: 0)) as? MostSoldTableViewCell else { return UITableViewCell() }
                cell.configureCell(mostSold: element)
                return cell
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(Products.self)
            .subscribe(onNext:  { value in
                
            })
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        viewModel.pageIndex.accept(pageControl.currentPage)
    }
}

