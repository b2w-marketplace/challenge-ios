//
//  PresentationView.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 16/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

protocol PresentationView: class {
    var errorView: ErrorView! { get set }
    var loadingView: LoadingView! { get set }
    func presentLoading()
    func dismissLoading()
    func setupView(parentView: UIView)
}

extension PresentationView where Self: UIView {
    
    func presentLoading() {
        DispatchQueue.main.async {
            self.loadingView.isHidden = false
        }
    }
    
    func dismissLoading() {
        DispatchQueue.main.async {
            self.loadingView.isHidden = true
        }
    }

    func setupView(parentView: UIView) {
        backgroundColor = .blue
        parentView.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        let safeArea = parentView.safeAreaLayoutGuide
        topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
        errorView = ErrorViewFactory.make(parentView: parentView)
        loadingView = LoadingViewFactory.make(parentView: parentView)
    }
    
}
