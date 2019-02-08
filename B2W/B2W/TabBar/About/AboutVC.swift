//
//  AboutVC.swift
//  B2W
//
//  Created by Nicholas Matos on 2/5/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit

protocol AboutDelegate {
    func documentationAction()
    func portfolioAction()
}

class AboutVC: UIViewController {
    var delegate: AboutDelegate?

    @IBOutlet weak var documentationButton: UIButton!
    @IBOutlet weak var portfolioButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        documentationButton.layer.masksToBounds = true
        documentationButton.layer.cornerRadius = 5
        
        documentationButton.backgroundColor = UIColor.init(netHex: kAppColor)
        
        portfolioButton.layer.masksToBounds = true
        portfolioButton.layer.cornerRadius = 5
        
        portfolioButton.backgroundColor = UIColor.init(netHex: kAppColor)
    }
    
    //Portfolio

    @IBAction func portfolioAction(_ sender: Any) {
        delegate?.portfolioAction()
    }
    
    @IBAction func documentationAction(_ sender: Any) {
        delegate?.documentationAction()
    }
}
