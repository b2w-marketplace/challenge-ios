//
//  AboutViewController.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 07/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import UIKit

class AboutViewController: AbstractViewController<AboutViewModel> {

    @IBOutlet weak var developerImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setuping views
        setupAccessibilities()
        setupNavigationBar()
        setupDeveloperImage()
        
        // loading view data
        loadingDeveloperImage()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    //MARK: Private methods
    final fileprivate func setupAccessibilities() {
        view.accessibilityIdentifier = "AboutViewController"
    }
    
    final fileprivate func setupNavigationBar() {
        title = vm.getNavigationTitle()
    }
    
    final fileprivate func setupDeveloperImage() {
        developerImage.layer.cornerRadius = developerImage.frame.height / 2
        developerImage.layer.masksToBounds = true
        developerImage.layer.borderColor = UIColor.gray.cgColor
        developerImage.layer.borderWidth = 1.5
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(retryLoadingImage))
        tapGesture.numberOfTapsRequired = 1
        developerImage.addGestureRecognizer(tapGesture)
        developerImage.isUserInteractionEnabled = true
    }
    
    @objc final fileprivate func retryLoadingImage() {
        if developerImage.image == nil {
            loadingDeveloperImage()
        }
    }
    
    final fileprivate func loadingDeveloperImage() {
        developerImage.setImageFrom(url: vm.getDeveloperImageUrl())
    }
}
