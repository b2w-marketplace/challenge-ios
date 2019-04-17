//
//  ViewController.swift
//  Lodjinha
//
//  Created by Marcos on 17/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var presenter: HomePresenterProtocol!
    
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

// MARK: - HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
    
    func showAlert(message: String) {
        
    }
    
}

