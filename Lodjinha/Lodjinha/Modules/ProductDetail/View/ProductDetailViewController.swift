//
//  ProductDetailViewController.swift
//  Lodjinha
//
//  Created on 22/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit

final class ProductDetailViewController: UIViewController {
    
    var presenter: ProductDetailPresenterProtocol!
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccessibilityIdentifiers()
        applyLanguage()
        applyStyle()
    }
    
    // MARK: - Setup Methods
    private func setupAccessibilityIdentifiers() {
        
    }
    
    private func applyLanguage() {
        
    }
    
    private func applyStyle() {
        
    }
    
}

// MARK: - ProductDetailViewProtocol
extension ProductDetailViewController: ProductDetailViewProtocol {
    
}
