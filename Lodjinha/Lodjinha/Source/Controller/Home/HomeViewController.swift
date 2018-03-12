//
//  HomeViewController.swift
//  Lodjinha
//
//  Created by Guilherme Antunes on 09/03/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - General Methods
    private func setupScreen() {
        let navView = UIView()
        
        let label = UILabel()
        label.text = " a Lodjinha"
        label.sizeToFit()
        label.center = navView.center
        label.textAlignment = .center
        label.font = UIFont(name: "Pacifico-Regular", size: 18)!
        label.textColor = .white
        label.numberOfLines = 0
        label.frame.size = label.intrinsicContentSize
        
        let image = UIImage(named: "logoSobre")!
        let imageView = UIImageView(image: image)
        
        let imageAspect = imageView.image!.size.width/imageView.image!.size.height
        imageView.frame = CGRect(x: label.frame.origin.x-label.frame.size.height*imageAspect, y: label.frame.origin.y, width: label.frame.size.height*imageAspect, height: label.frame.size.height)
        imageView.contentMode = .scaleAspectFit
        
        navView.addSubview(imageView)
        navView.addSubview(label)
        
        navigationItem.titleView = navView
        navView.sizeToFit()
    }
    
    // MARK: - Actions

}
