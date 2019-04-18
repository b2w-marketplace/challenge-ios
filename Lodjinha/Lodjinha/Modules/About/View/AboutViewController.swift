//
//  AboutViewController.swift
//  Lodjinha
//
//  Created on 17/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit

final class AboutViewController: UIViewController {
    
    var presenter: AboutPresenterProtocol!
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccessibilityIdentifiers()
        applyLanguage()
        applyStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Setup Methods
    private func setupAccessibilityIdentifiers() {
        
    }
    
    private func applyLanguage() {
        title = String(identifier: .about)
    }
    
    private func applyStyle() {
        
    }
    
}

// MARK: - AboutViewProtocol
extension AboutViewController: AboutViewProtocol {
    
}
