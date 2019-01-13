//
//  UIViewExtension.swift
//  Lodjinha
//
//  Created by Lucas Gonçalves Serrano on 10/01/19.
//  Copyright © 2019 Lucas Gonçalves Serrano. All rights reserved.
//

import UIKit

extension UIView {
    func addTopBorder(color: UIColor, width: CGFloat) {
        let topBorderView = UIView(frame: CGRect.zero)
        topBorderView.backgroundColor = color
        self.addSubview(topBorderView)
        topBorderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topBorderView.topAnchor.constraint(equalTo: self.topAnchor),
            topBorderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topBorderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topBorderView.heightAnchor.constraint(equalToConstant: width)
            ])
    }

    func addBottomBorder(color: UIColor, width: CGFloat) {
        let bottomBorderView = UIView(frame: CGRect.zero)
        bottomBorderView.backgroundColor = color
        self.addSubview(bottomBorderView)
        bottomBorderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomBorderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomBorderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomBorderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomBorderView.heightAnchor.constraint(equalToConstant: width)
            ])
    }
}
