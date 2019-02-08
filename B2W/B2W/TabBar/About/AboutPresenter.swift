//
//  AboutPresenter.swift
//  B2W
//
//  Created by Nicholas Matos on 2/5/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit

class AboutPresenter: NSObject, AboutDelegate {
    let aboutView = AboutVC(nibName: "AboutVC", bundle: Bundle.main)
    
    override init() {
        super.init()
        aboutView.delegate = self
    }
    
    func documentationAction(){
        self.openUrlLink(link: kAboutDocumentationLink)
    }
    
    func portfolioAction() {
        self.openUrlLink(link: kAboutPortfolioLink)
    }
    
    func openUrlLink(link: String){
        guard let url = URL(string: link) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
