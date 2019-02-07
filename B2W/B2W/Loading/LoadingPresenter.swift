//
//  LoadingPresenter.swift
//  B2W
//
//  Created by Nicholas Matos on 2/7/19.
//  Copyright © 2019 Nicholas Matos. All rights reserved.
//

import UIKit

class LoadingPresenter: NSObject {
    let loadingView = UINib(nibName: "LoadingView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
    let appDelegate : AppDelegate =  UIApplication.shared.delegate as! AppDelegate
    
    func showLoading(){
        loadingView.backgroundColor = UIColor.init(netHex: kAppColor)
        self.loadingView.alpha = 0.0
        loadingView.frame = appDelegate.window!.bounds
        appDelegate.window?.addSubview(loadingView)
        
        UIView.animate(withDuration: kLoadingTimeAnimation, delay: 0, options: UIView.AnimationOptions(), animations:
            {
                self.loadingView.alpha = 1.0
        }, completion: nil)
    }
    
    func hideLoading(){
        UIView.animate(withDuration: kLoadingTimeAnimation, animations:
            {
                self.loadingView.alpha = 0.0
        }, completion: { (finished: Bool) in
            self.loadingView.removeFromSuperview()
        })
    }
}
