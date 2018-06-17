//
//  AboutViewController.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 16/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    private var mainView: AboutView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        mainView = AboutView(parentView: view)
        title = R.string.navigationBar.about()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Erro")
    }
    
}
