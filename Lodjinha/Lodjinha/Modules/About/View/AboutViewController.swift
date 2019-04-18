//
//  AboutViewController.swift
//  Lodjinha
//
//  Created on 17/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import UIKit

final class AboutViewController: UIViewController {
    
    @IBOutlet private weak var labelLogoTitle: UILabel!
    @IBOutlet private weak var labelName: UILabel!
    @IBOutlet private weak var labelDate: UILabel!
    
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
        labelLogoTitle.accessibilityIdentifier = "labelLogoTitle"
        labelName.accessibilityIdentifier = "labelName"
        labelDate.accessibilityIdentifier = "labelDate"
    }
    
    private func applyLanguage() {
        title = String(identifier: .about)
        labelLogoTitle.text = String(identifier: .theLodjinha)
        labelName.text = String(identifier: .devName)
        labelDate.text = Date().stringDate()
    }
    
    private func applyStyle() {
        Style.text(font: UIFont.pacifico(style: .regular, size: 65),
                   color: Palette.Gray.main.color,
                   alignment: .center)
            .apply(on: labelLogoTitle)
        
        Style.text(font: UIFont.boldSystemFont(ofSize: 12),
                   color: Palette.Gray.main.color,
                   alignment: .center)
            .apply(on: labelName)
        
        Style.text(font: UIFont.systemFont(ofSize: 12),
                   color: Palette.Gray.main.color,
                   alignment: .center)
            .apply(on: labelDate)
    }
    
}

// MARK: - AboutViewProtocol
extension AboutViewController: AboutViewProtocol {
    
}
