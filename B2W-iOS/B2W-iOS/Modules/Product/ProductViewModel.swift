//
//  ProductViewModel.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 10/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import UIKit

protocol ProductViewModelDelegate: class {
    func onSuccessWith(feedback message: String)
    func onError(feedback message: String)
    func loader(isShow: Bool, type: LoaderType)
    func popViewController()
}

protocol ProductViewModelInterface: ViewModelInterface {
    func setModel(_ model: ProductModel)
    func getProductName() -> String?
    func getNumberOfRowsIn(section: Int) -> Int
    func getNumberOfSections() -> Int
    func getCellFor(table: UITableView, index: IndexPath) -> UITableViewCell
    func didReserveProduct()
    func didConfirmSuccess()
}

class ProductViewModel: ProductViewModelInterface {
    
    enum ProductDataSource {
        case product(imageUrl: String?, name: String?)
        case price(priceOff: Float?, salePrice: Float?)
        case description(title: String?, textDescription: String?)
    }
    
    weak var delegate: ProductViewModelDelegate?
    final fileprivate var dataSource: [ProductDataSource]
    final fileprivate var product: ProductModel?
    final private var service: APIService
    
    required init() {
        service = APIService()
        dataSource = []
    }
    
    func setModel(_ model: ProductModel) {
        product = model
        dataSource.append(.product(imageUrl: model.urlImagem, name: model.name))
        dataSource.append(.price(priceOff: model.priceOff, salePrice: model.salePrice))
        dataSource.append(.description(title: model.name, textDescription: model.description))
    }
    
    func getProductName() -> String? {
        return product?.category?.description
    }
    
    func getNumberOfRowsIn(section: Int) -> Int {
        return dataSource.count
    }
    
    func getNumberOfSections() -> Int {
        return 1
    }
    
    func getCellFor(table: UITableView, index: IndexPath) -> UITableViewCell {
        switch dataSource[index.row] {
        case .product(let imageUrl, let name):
            guard let cell = table.dequeueReusableCell(ProductTableViewCell.self, indexPath: index) else {
                return UITableViewCell()
            }
            cell.contructWith(productImageUrl: imageUrl, productName: name)
            return cell
        case .price(let priceOff, let salePrice):
            guard let cell = table.dequeueReusableCell(PriceTableViewCell.self, indexPath: index) else {
                return UITableViewCell()
            }
            cell.contructWith(priceOff: priceOff ?? 0.0, salePrice: salePrice ?? 0.0)
            return cell
        case .description(let title, let textDescription):
            guard let cell = table.dequeueReusableCell(SimpleTitleAndTextTableViewCell.self, indexPath: index) else {
                return UITableViewCell()
            }
            cell.contructWith(title: title, textDescription: textDescription)
            return cell
        }
    }
    
    func didReserveProduct() {
        guard let id = product?.id else {
            return
        }
        postReserveProduct(id)
    }
    
    func didConfirmSuccess() {
        delegate?.popViewController()
    }
}

//MARK: Private methods
extension ProductViewModel {
    final fileprivate func postReserveProduct(_ id: Int) {
        delegate?.loader(isShow: true, type: .view)
        service.postReserveProduct(id: id){ [weak self] (result) in
            switch result {
            case .success:
                self?.delegate?.onSuccessWith(feedback: "Produto reservado com sucesso")
            case .failure(let error):
                self?.delegate?.onError(feedback: error.localizedDescription)
            }
            self?.delegate?.loader(isShow: false, type: .view)
        }
    }
}
