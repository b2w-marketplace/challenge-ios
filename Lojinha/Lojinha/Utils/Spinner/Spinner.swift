//
//  Spinner.swift
//  Lojinha
//
//  Created by Rodrigo Miyashiro on 12/02/18.
//  Copyright © 2018 Rodrigo Miyashiro. All rights reserved.
//

import UIKit

class Spinner: NSObject
{
    struct ActivitySize
    {
        static let height: CGFloat = 60.0
        static let width: CFloat  = 60.0
    }
    
    static var viewActivity : UIView?
    static var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    private static func createSppiner(view: UIView) -> UIView
    {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor().purple()
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
    
    static func show(view:UIView)
    {
        let mainView = UIApplication.shared.keyWindow!.rootViewController!.view!
        
        viewActivity = UIView(frame: CGRect(x: mainView.frame.origin.x, y: mainView.frame.origin.y, width: mainView.frame.width, height: mainView.frame.height))
        viewActivity!.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        viewActivity!.center = view.center
        view.addSubview(viewActivity!)
        
        self.activityIndicator = createSppiner(view: view) as! UIActivityIndicatorView
    }
    
    static func stopAnimating()
    {
        self.viewActivity?.isHidden = true
        self.activityIndicator.stopAnimating()
        viewActivity?.removeFromSuperview()
    }
}
