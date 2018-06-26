//
//  ErrorView.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 16/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

final class ErrorView: UIView {
    
    private let message: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 0
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
    
    @available(iOS 11.0, *)
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
    }
    
    func update(messageText: String) {
        DispatchQueue.main.async {
            self.message.text = messageText.uppercased()
        }
    }
}

extension ErrorView: ViewConfiguration {
    
    func buildViewHierarchy() {
        addSubview(message)
    }
    
    func setupConstraints() {
        message.topAnchor.constraint(equalTo: topAnchor).isActive = true
        message.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        message.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        message.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
    }
}
