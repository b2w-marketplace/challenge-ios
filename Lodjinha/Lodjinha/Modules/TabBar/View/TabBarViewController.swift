//
//  TabBarViewController.swift
//  Lodjinha
//
//  Created on 17/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController, TabBarViewProtocol {
    
    var presenter: TabBarPresenterProtocol!
    
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
