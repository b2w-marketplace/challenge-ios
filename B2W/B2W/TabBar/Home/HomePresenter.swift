//
//  HomePresenter.swift
//  B2W
//
//  Created by Nicholas Matos on 2/5/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit

class HomePresenter: NSObject, HomeVCDelegate {
    let homeView = HomeVC(nibName: "HomeVC", bundle: Bundle.main)
    
    override init() {
        super.init()
        homeView.delegate = self
    }
    
    func didLoad(){
        
    }
}
