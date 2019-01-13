//
//  CategoryViewModel.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 09/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import UIKit

protocol CategoryViewModelDelegate: class {
    func reloadData()
    func onError(feedback message: String)
    func loader(isShow: Bool, type: LoaderType)
    func pushNavigationTo(_ viewController: UIViewController)
}

protocol CategoryViewModelInterface: ViewModelInterface {
    func setModel(_ model: GenericListModel<ProductModel>)
    func getCategoryName() -> String?
    func getNumberOfRowsIn(section: Int) -> Int
    func getNumberOfSections() -> Int
    func getCellFor(table: UITableView, index: IndexPath) -> UITableViewCell
    func didSelectIndex(_ index: IndexPath)
    func didPullRefresh()
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}

class CategoryViewModel: CategoryViewModelInterface {
    
    weak var delegate: CategoryViewModelDelegate?
    final fileprivate var dataSource: GenericListModel<ProductModel>
    final fileprivate var category: CategoryModel?
    final fileprivate var isPageRefreshing: Bool = false
    final fileprivate var lastContentOffset: CGFloat = 0
    final private var service: APIService

    required init() {
        service = APIService()
        dataSource = GenericListModel()
    }
    
    func setModel(_ model: GenericListModel<ProductModel>) {
        dataSource = model
        
        if let objs = model.objects, objs.count > 0 {
            category = objs[0].category
        }
    }
    
    func getCategoryName() -> String? {
        return category?.description
    }
    
    func getNumberOfRowsIn(section: Int) -> Int {
        return dataSource.objects?.count ?? 0
    }
    
    func getNumberOfSections() -> Int {
        return 1
    }
    
    func getCellFor(table: UITableView, index: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(ProductListTableViewCell.self, indexPath: index) else {
            return UITableViewCell()
        }
        let model = dataSource.objects?[index.row]
        cell.constructWith(productImageUrl: model?.urlImagem,
                           productName: model?.name,
                           priceOff: model?.priceOff ?? 0.0,
                           salePrice: model?.salePrice ?? 0.0)
        cell.accessibilityIdentifier = "ProductListTableViewCell\(index.row)"
        return cell
    }
    
    func didSelectIndex(_ index: IndexPath) {
        guard let model = dataSource.objects?[index.row] else {
            return
        }
        showProductViewController(model: model)
    }
    
    func didPullRefresh() {
        retryLoadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        let targetOffset: CGFloat = 90.0
        
        if deltaOffset <= targetOffset && !isPageRefreshing && lastContentOffset < scrollView.contentOffset.y {
            startPagination()
        }
    }
}

//MARK: Private methods
extension CategoryViewModel {
    final fileprivate func retryLoadData() {
        if let id = category?.id {
            dataSource.objects?.removeAll()
            delegate?.reloadData()
            
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) { [weak self] in
                self?.getProductsByCategory(id: id, offset: 1, loaderType: .refreshControl)
            }
        }
    }
    
    final fileprivate func startPagination() {
        if let id = category?.id, dataSource.hasNextPage {
            let page = (dataSource.offset ?? 0) + 1
            getProductsByCategory(id: id,
                                  offset: page,
                                  loaderType: .footerTableView)
        }
    }
    
    // Flow
    final fileprivate func showProductViewController(model: ProductModel) {
        let vc = StoryboardScene.Home.productViewControllerID.instantiate()
        vc.vm.setModel(model)
        delegate?.pushNavigationTo(vc)
    }
    
    // API
    final fileprivate func getProductsByCategory(id: Int, offset: Int, loaderType: LoaderType) {
        isPageRefreshing = true
        delegate?.loader(isShow: true, type: loaderType)
        service.getProductsByCategory(id: id, offset: offset) { [weak self] (result) in
            switch result {
            case .success(let value):
                if offset == 1 {
                    self?.dataSource = value
                    self?.delegate?.reloadData()
                } else if let oldObjs = self?.dataSource.objects,
                          let newObjs = value.objects, newObjs.count > 0 {
                    value.objects?.insert(contentsOf: oldObjs, at: 0)
                    self?.dataSource = value
                    self?.delegate?.reloadData()
                } else {
                    self?.dataSource.hasNextPage = false
                }
            case .failure(let error):
                self?.delegate?.onError(feedback: error.localizedDescription)
            }
            self?.isPageRefreshing = false
            self?.delegate?.loader(isShow: false, type: loaderType)
        }
    }
}
