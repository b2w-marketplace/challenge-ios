//
//  BannerViewController.swift
//  Lodjinha
//
//  Created by Guilherme Antunes on 10/03/18.
//  Copyright © 2018 Guilherme Antunes. All rights reserved.
//

import UIKit

class BannerViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var bannerImageView: UIImageView!
    
    // MARK: - Properties
    private var banner : Banner?
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
    }
    
    // MARK: - General Methods
    public func setBanner(_ banner : Banner?) {
        self.banner = banner
    }
    
    private func loadImage() {
        guard let urlString = banner?.imageUrl else {
            return
        }
        guard let url = URL(string: urlString) else {
            return
        }
        
        bannerImageView.af_setImage(withURL: url, progressQueue: .global(), imageTransition: .noTransition, runImageTransitionIfCached: false)
        bannerImageView.af_setImage(withURL: url, progressQueue: .global(), imageTransition: .noTransition, runImageTransitionIfCached: false) { (response) in
            createGradient(frame: self.bannerImageView.frame, forView: self.bannerImageView)
        }
    }
    
    // MARK: - Actions

}
