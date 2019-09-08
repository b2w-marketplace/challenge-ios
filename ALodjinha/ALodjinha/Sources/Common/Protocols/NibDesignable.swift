//
//  NibDesignable.swift
//  ALodjinha
//
//  Created by Luis Ferreira on 06/09/19.
//  Copyright © 2019 Luis Ferreira. All rights reserved.
//

import UIKit

protocol NibDesignable {
    func loadNib(_ bundle: Bundle?, name: String?)
}

extension NibDesignable where Self: UIView {
    private func nibName() -> String {
        return type(of: self).description().components(separatedBy: ".").last!
    }
    
    func nibBundle() -> Bundle {
        return Bundle(for: type(of: self))
    }
    
    func loadNib(_ bundle: Bundle? = nil, name: String? = nil) {
        let bundle = bundle ?? nibBundle()
        let name = name ?? nibName()
        
        guard let view = UINib(nibName: name, bundle: bundle).instantiate(withOwner: self,
                                                                          options: .none).first as? UIView else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
