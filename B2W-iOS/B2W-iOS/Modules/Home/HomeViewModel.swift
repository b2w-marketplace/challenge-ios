//
//  HomeViewModel.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 08/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import UIKit

protocol HomeViewModelDelegate: class {
    func reloadData()
    func onError(feedback message: String)
    func loader(isShow: Bool, type: LoaderType)
    func pushNavigationTo(_ viewController: UIViewController)
}

protocol HomeViewModelInterface: ViewModelInterface {
    func loadData()
    func getNumberOfRowsIn(section: Int) -> Int
    func getNumberOfSections() -> Int
    func getHeaderHeightFor(section: Int) -> CGFloat
    func getHeaderViewFor(section: Int) -> UIView?
    func getCellFor(table: UITableView, index: IndexPath) -> UITableViewCell
    func didSelectIndex(_ index: IndexPath)
    func didPullRefresh()
}

class HomeViewModel: HomeViewModelInterface {
    
    enum HomeDataSource {
        case banner([BannerModel])
        case category([CategoryModel])
        case bestSellers(ProductModel)
        case none
    }
    
    weak var delegate: HomeViewModelDelegate?
    final fileprivate var dataSource: [[HomeDataSource]]
    final fileprivate var requestStatusControl: (bannerIsRefreshing: Bool, categoryIsRefreshing: Bool, bestSellersIsRefreshing: Bool)
    final private var service: APIService

    required init() {
        service = APIService()
        requestStatusControl = (false, false, false)
        dataSource = [[.none],[.none],[.none]]
    }
    
    func loadData() {
        getBanners(loaderType: .view)
        getCategoies(loaderType: .view)
        getBestSellers(loaderType: .view)
    }
    
    func getNumberOfRowsIn(section: Int) -> Int {
        return dataSource[section].count
    }
    
    func getNumberOfSections() -> Int {
        return dataSource.filter({ (dataType) -> Bool in
            switch dataType[0] {
            case .none:
                return false
            default:
                return true
            }
        }).count
    }
    
    func getHeaderHeightFor(section: Int) -> CGFloat {
        switch dataSource[section][0] {
        case .category, .bestSellers:
            return 30.0
        default:
            return 0.0
        }
    }
    
    func getHeaderViewFor(section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 20))
        view.backgroundColor = .white
        
        let lineView = UIView(frame: .zero)
        lineView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        view.addSubview(lineView)
        
        let views = ["lineView": lineView, "label": label]
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[lineView]-|",
                                                                   options: [],
                                                                   metrics: nil,
                                                                   views: views)
        
        let horizontalLabelConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[label]-|",
                                                                        options: [],
                                                                        metrics: nil,
                                                                        views: views)
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[label]-[lineView(1)]|",
                                                                 options: [],
                                                                 metrics: nil,
                                                                 views: views)
        
        view.addConstraints(horizontalConstraints)
        view.addConstraints(horizontalLabelConstraints)
        view.addConstraints(verticalConstraints)
        
        switch dataSource[section][0] {
        case .banner:
            return nil
        case .category:
            label.text = "Categorias"
        case .bestSellers:
            label.text = "Mais Vendidos"
        default:
            return nil
        }
        
        return view
    }
    
    func getCellFor(table: UITableView, index: IndexPath) -> UITableViewCell {
        switch dataSource[index.section][index.row] {
        case .banner(let model):
            guard let cell = table.dequeueReusableCell(BannerTableViewCell.self, indexPath: index) else {
                return UITableViewCell()
            }
            cell.constructWith(banners: model, delegate: self)
            cell.accessibilityIdentifier = "BannerTableViewCell\(index.row)"
            return cell
        case .category(let model):
            guard let cell = table.dequeueReusableCell(CategoryTableViewCell.self, indexPath: index) else {
                return UITableViewCell()
            }
            cell.constructWith(categories: model, delegate: self)
            cell.accessibilityIdentifier = "CategoryTableViewCell\(index.row)"
            return cell
        case .bestSellers(let model):
            guard let cell = table.dequeueReusableCell(ProductListTableViewCell.self, indexPath: index) else {
                return UITableViewCell()
            }
            cell.constructWith(productImageUrl: model.urlImagem,
                              productName: model.name,
                              priceOff: model.priceOff ?? 0.0,
                              salePrice: model.salePrice ?? 0.0)
            cell.accessibilityIdentifier = "ProductListTableViewCell\(index.row)"
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func didSelectIndex(_ index: IndexPath) {
        switch dataSource[index.section][index.row] {
        case .bestSellers(let model):
            showProductViewController(model: model)
        default:
            break
        }
    }
    
    func didPullRefresh() {
        retryLoadData()
    }
}

//MARK: Private methods
extension HomeViewModel {
    final fileprivate func retryLoadData() {
        dataSource = [[.none],[.none],[.none]]
        delegate?.reloadData()
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.getBanners(loaderType: .refreshControl)
            self?.getCategoies(loaderType: .refreshControl)
            self?.getBestSellers(loaderType: .refreshControl)
        }
    }
    
    final private func managementHidingLoader(type: LoaderType) {
        if requestStatusControl.bannerIsRefreshing == false &&
           requestStatusControl.categoryIsRefreshing == false &&
            requestStatusControl.bestSellersIsRefreshing == false {
            delegate?.loader(isShow: false, type: type)
        }
    }
    
    // Flow
    final fileprivate func showProductViewController(model: ProductModel) {
        let vc = StoryboardScene.Home.productViewControllerID.instantiate()
        vc.vm.setModel(model)
        delegate?.pushNavigationTo(vc)
    }
    
    final fileprivate func showCategoryViewController(model: GenericListModel<ProductModel>) {
        let vc = StoryboardScene.Home.categoryViewControllerID.instantiate()
        vc.vm.setModel(model)
        delegate?.pushNavigationTo(vc)
    }
    
    // API
    final fileprivate func getBanners(loaderType: LoaderType) {
        delegate?.loader(isShow: true, type: loaderType)
        service.getBanner { [weak self] (result) in
            switch result {
            case .success(let value):
                let model = [HomeDataSource.banner(value.objects ?? [])]
                self?.dataSource[0] = model
                self?.delegate?.reloadData()
            case .failure(let error):
                self?.delegate?.onError(feedback: error.localizedDescription)
            }
            self?.managementHidingLoader(type: loaderType)
        }
    }
    
    final fileprivate func getCategoies(loaderType: LoaderType) {
        delegate?.loader(isShow: true, type: loaderType)
        service.getCategories { [weak self] (result) in
            switch result {
            case .success(let value):
                let model = [HomeDataSource.category(value.objects ?? [])]
                self?.dataSource[1] = model
                self?.delegate?.reloadData()
            case .failure(let error):
                self?.delegate?.onError(feedback: error.localizedDescription)
            }
            self?.managementHidingLoader(type: loaderType)
        }
    }
    
    final fileprivate func getBestSellers(loaderType: LoaderType) {
        delegate?.loader(isShow: true, type: loaderType)
        service.getBestSellers { [weak self] (result) in
            switch result {
            case .success(let value):
                let model = value.objects?.compactMap({ HomeDataSource.bestSellers($0) }) ?? []
                self?.dataSource[2] = model
                self?.delegate?.reloadData()
            case .failure(let error):
                self?.delegate?.onError(feedback: error.localizedDescription)
            }
            self?.managementHidingLoader(type: loaderType)
        }
    }
    
    final fileprivate func getProductsByCategory(id: Int, offset: Int, loaderType: LoaderType) {
        delegate?.loader(isShow: true, type: loaderType)
        service.getProductsByCategory(id: id, offset: offset) { [weak self] (result) in
            switch result {
            case .success(let value):
                self?.showCategoryViewController(model: value)
            case .failure(let error):
                self?.delegate?.onError(feedback: error.localizedDescription)
            }
            self?.delegate?.loader(isShow: false, type: loaderType)
        }
    }
}

//MARK: Delegates
extension HomeViewModel: CategoryCellDelegate {
    func didSelect(category: CategoryModel) {
        guard let id = category.id else {
            return
        }
        getProductsByCategory(id: id, offset: 1, loaderType: .view)
    }
}

extension HomeViewModel: BannerCellDelegate {
    func didSelect(banner: BannerModel) {
        guard let urlString = banner.linkUrl, let url = URL(string: urlString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        }
    }
}
