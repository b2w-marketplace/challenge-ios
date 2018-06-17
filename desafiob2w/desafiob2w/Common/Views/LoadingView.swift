//
//  LoadingView.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 16/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

final class LoadingView: UIView {
    
    private let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    private let message: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Rodando..."
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    init(parentView: UIView) {
        super.init(frame: .zero)
        setupView(parentView: parentView)
        setupViewConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error")
    }
    
    private func setupView(parentView: UIView) {
        parentView.bringSubview(toFront: self)
        isHidden = true
        parentView.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        let safeArea = parentView.safeAreaLayoutGuide
        topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

extension LoadingView: ViewConfiguration {
    
    func buildViewHierarchy() {
        addSubview(message)
        addSubview(indicator)
    }
    
    func setupConstraints() {
        message.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        message.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        message.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        message.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        indicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indicator.bottomAnchor.constraint(equalTo: message.topAnchor, constant: -20.0).isActive = true
    }
    
    func configureViews() {
        indicator.startAnimating()
        indicator.color = .black
    }
    
}
