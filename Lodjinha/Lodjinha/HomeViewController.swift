//
//  HomeViewController.swift
//  Lodjinha
//
//  Created by Gustavo Azevedo de Oliveira on 10/03/19.
//  Copyright © 2019 Gustavo Azevedo de Oliveira. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationTitle()
    }
    
    private func setNavigationTitle() {
        let titleImage = UIImage(named: "nav_title")
        let titleIv = UIImageView(image: titleImage)
        self.navigationItem.titleView = titleIv
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
