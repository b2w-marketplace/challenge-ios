//
//  HomeViewController.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 16/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    private var mainView: HomeView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        mainView = HomeView(parentView: view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Erro")
    }
 
}
