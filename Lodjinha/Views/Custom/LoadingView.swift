//
//  LoadingView.swift
//  Lodjinha
//
//  Created by André Assis on 15/06/18.
//  Copyright © 2018 André Assis. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    private var activityIndicator: UIActivityIndicatorView!
    private var errorView: UIView!
    private var errorLabel: UILabel!
    
    private var setup: Bool = true
    
    private var callback: (()->(Void))?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if setup {
            setup = false
            
            self.backgroundColor = UIColor.white
            self.addSubview(activityIndicator)
            self.addConstraint(NSLayoutConstraint.init(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0))
            self.addConstraint(NSLayoutConstraint.init(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0))
            
            self.addSubview(errorView)
            self.addConstraint(NSLayoutConstraint.init(item: errorView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0))
            self.addConstraint(NSLayoutConstraint.init(item: errorView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0))
            errorView.alpha = 0.0
        }
    }
    
    override init(frame: CGRect) {
        
        activityIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        
        errorLabel = UILabel.init()
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        errorLabel.numberOfLines = 0
        errorLabel.lineBreakMode = .byWordWrapping
        errorLabel.textAlignment = .center
        errorLabel.text = "Ocorreu um erro durante a solicitação,\ntoque para tentar novamente."
        
        errorView = UIView.init(frame: CGRect(x: 0, y: 0, width: 200.0, height: 40))
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.addSubview(errorLabel)
        errorView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[label]-0-|", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: nil, views: ["label": errorLabel]))
        errorView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[label]-0-|", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: nil, views: ["label": errorLabel]))
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setCallback(_ callback: @escaping (()->(Void))) {
        self.callback = callback
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(retryError))
        errorView.addGestureRecognizer(tap)
    }
    
    @objc private func retryError() {
        if let c = callback {
            showLoading()
            c()
        }
    }
    
    func show() {
        self.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1.0
        }
    }
    
    func displayError() {
        activityIndicator.stopAnimating()
        UIView.animate(withDuration: 0.2) {
            self.errorView.alpha = 1.0
        }
    }
    
    func showLoading() {
        activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.2) {
            self.errorView.alpha = 0.0
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0.0
        }) { (c) in
            self.isHidden = true
        }
    }
    
}
