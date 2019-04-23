//
//  ProductDetailViewController.swift
//  Lodjinha
//
//  Created on 22/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

final class ProductDetailViewController: UIViewController {
    
    @IBOutlet private weak var scrollView: UIScrollView!
    
    @IBOutlet private weak var imageViewProduct: UIImageView!
    
    @IBOutlet private weak var labelProductName: UILabel!
    @IBOutlet private weak var labelPriceTo: UILabel!
    @IBOutlet private weak var labelPriceFrom: UILabel!
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var labelDescription: UILabel!
    @IBOutlet private weak var labelEmptyState: UILabel!
    
    @IBOutlet private weak var buttonReservation: UIButton!
    
    @IBOutlet private weak var activityIndicatorContainerView: UIView!
    
    @IBOutlet private weak var activityIndicatorView: NVActivityIndicatorView!
    
    var presenter: ProductDetailPresenterProtocol!
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccessibilityIdentifiers()
        applyLanguage()
        applyStyle()
        setupTabBar()
        
        presenter.viewDidLoad()
    }
    
    // MARK: - Setup Methods
    private func setupAccessibilityIdentifiers() {
        scrollView.accessibilityIdentifier = "scrollView"
        
        imageViewProduct.accessibilityIdentifier = "imageViewProduct"
        
        labelProductName.accessibilityIdentifier = "labelProductName"
        labelPriceTo.accessibilityIdentifier = "labelPriceTo"
        labelPriceFrom.accessibilityIdentifier = "labelPriceFrom"
        labelTitle.accessibilityIdentifier = "labelTitle"
        labelDescription.accessibilityIdentifier = "labelDescription"
        labelEmptyState.accessibilityIdentifier = "labelEmptyState"
        
        activityIndicatorContainerView.accessibilityIdentifier = "activityIndicatorContainerView"
        
        activityIndicatorView.accessibilityIdentifier = "activityIndicatorView"
    }
    
    private func applyLanguage() {
        title = presenter.title
        navigationController?.addBackButton(title: String(identifier: .back))
        labelEmptyState.text = String(identifier: .emptyStateProductDetail)
        labelProductName.text = String()
        labelPriceTo.text = String()
        labelPriceFrom.text = String()
        labelTitle.text = String()
        labelDescription.text = String()
        labelEmptyState.text = String()
    }
    
    private func applyStyle() {
        Style.text(font: UIFont.systemFont(ofSize: 15),
                   color: Palette.Gray.dark.color,
                   alignment: .left)
            .apply(on: labelProductName)
        
        Style.text(font: UIFont.systemFont(ofSize: 12),
                   color: Palette.Gray.light.color,
                   alignment: .left)
            .apply(on: labelPriceFrom)
        
        Style.text(font: UIFont.boldSystemFont(ofSize: 18),
                   color: Palette.Orange.main.color,
                   alignment: .right)
            .apply(on: labelPriceTo)
        
        Style.text(font: UIFont.boldSystemFont(ofSize: 14),
                   color: Palette.Gray.dark.color,
                   alignment: .left)
            .apply(on: labelTitle)
        
        Style.text(font: UIFont.systemFont(ofSize: 14),
                   color: Palette.Gray.dark.color,
                   alignment: .left)
            .apply(on: labelDescription)
        
        Style.text(font: UIFont.systemFont(ofSize: 14),
                   color: Palette.Gray.main.color,
                   alignment: .center)
            .apply(on: labelEmptyState)
        
        Style.apply(onPrimaryButton: buttonReservation)
        activityIndicatorView.type = .ballRotateChase
        activityIndicatorView.color = Palette.Purple.main.color
    }
    
    private func setupTabBar() {
        tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction private func didSelectButtonReservation() {
        presenter.didSelectButtonReservation()
    }
    
}

// MARK: - ProductDetailViewProtocol
extension ProductDetailViewController: ProductDetailViewProtocol {
    
    func setup(product: Product) {
        if let url = URL(string: product.urlImagem) {
            imageViewProduct.af_setImage(withURL: url)
        }
        labelProductName.text = product.nome
        labelPriceFrom.attributedText = "\(String(identifier: .from)): \(product.precoDe.currency(by: NumberFormatter.currencyPtBr))".strikethrough
        labelPriceTo.text = "\(String(identifier: .to)): \(product.precoPor.currency(by: NumberFormatter.currencyPtBr))"
        labelTitle.text = product.categoria.descricao
        labelDescription.attributedText = product.descricao.html2AttributedString(font: UIFont.systemFont(ofSize: 14),
                                                                                  textColor: Palette.Gray.dark.color,
                                                                                  textAlignment: .left)
    }
    
    func showAlert(message: String) {
        presentAlert(message: message)
    }
    
    func showAlert(message: String, actionHandler: @escaping ((UIAlertAction) -> Void)) {
        presentAlert(message: message, actionHandler: actionHandler)
    }
    
    func showEmptyState() {
        scrollView.isHidden = true
        labelEmptyState.isHidden = false
    }
    
    func hideEmptyState() {
        scrollView.isHidden = false
        labelEmptyState.isHidden = true
    }
    
    func showActiveIndicator() {
        activityIndicatorContainerView.isHidden = false
        activityIndicatorView.startAnimating()
    }
    
    func hideActiveIndicator() {
        activityIndicatorContainerView.isHidden = true
        activityIndicatorView.stopAnimating()
    }
    
}
