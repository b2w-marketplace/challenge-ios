//
//  Styles.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation
import UIKit

extension StyleBuilder {
    
    // MARK: - Buttons
    func apply(onPrimaryButton stylable: Stylable) {
        if let button = stylable as? UIButton {
            button.backgroundColor = Palette.Purple.main.color
            button.setTitleColor(UIColor.white, for: .normal)
            button.layer.cornerRadius = 8.0
            Style.apply(onTextButton: button)
        }
    }
    
    func apply(onNavigationBar navigationBar: UINavigationBar) {
        navigationBar.barTintColor = .white
        navigationBar.shadowImage = UIImage()
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.tintColor = Palette.Purple.main.color
        navigationBar.backgroundColor = .clear
        navigationBar.isTranslucent = true
        
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.pacifico(style: .regular, size: 18)
        ]
    }
    
    func apply(onNavigationBarWithImageTitle navigationItem: UINavigationItem?) {
        guard let image = UIImage(identifier: .logoNavbar),
            let navigationItem = navigationItem else {
            return
        }
        let titleView = UIView(frame: CGRect(x: 0, y: -10, width: 120, height: 60))
        let imageView = UIImageView(image: image)
        imageView.frame = titleView.frame
        imageView.contentMode = .scaleAspectFit
        titleView.addSubview(imageView)
        navigationItem.titleView = titleView
    }
    
    func apply(onTextButton button: UIButton) {
        Style.text(font: UIFont.boldSystemFont(ofSize: 15),
                   color: UIColor.white,
                   alignment: .center)
            .apply(on: button)
    }
    
    func apply(onShadow view: UIView) {
        view.layer.shadowRadius = 2
        view.layer.cornerRadius = 5
        view.layer.shadowOpacity = 0.5
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 5)
    }
    
}

// MARK: - Static Styles
extension StyleBuilder {
    
    static func initialize() {
        let style = Style
        style.setupNavigationBar()
        style.setupTabBar()
        style.setupTabBarItem()
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBar.appearance()
        appearance.backgroundColor = .white
        appearance.barTintColor = Palette.Purple.main.color
        appearance.tintColor = .white
        appearance.isTranslucent = false
        appearance.titleTextAttributes = [ .font: UIFont.boldSystemFont(ofSize: 17),
                                           .foregroundColor: UIColor.white ]
    }
    
    private func setupTabBar() {
        let appearance = UITabBar.appearance()
        appearance.tintColor = Palette.Purple.main.color
    }
    
    private func setupTabBarItem() {
        //let appearance = UITabBarItem.appearance()
        //appearance.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 12)], for: .normal)
    }
    
}
