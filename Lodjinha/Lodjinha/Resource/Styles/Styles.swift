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
        stylable.applyBackgroundColor(Palette.Purple.main.color)
        stylable.applyBorderWidth(5.0)
    }
    
    func apply(onNavigationBar navigationBar: UINavigationBar) {
        navigationBar.barTintColor = .white
        navigationBar.shadowImage = UIImage()
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.tintColor = Palette.Purple.main.color
        navigationBar.backgroundColor = .clear
        navigationBar.isTranslucent = true
        
        navigationBar.titleTextAttributes = [
            .foregroundColor: Palette.Common.white.color,
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
        Style.text(font: UIFont.pacifico(style: .regular, size: 18),
                   color: Palette.Common.white.color,
                   alignment: .left)
            .apply(on: button)
    }
    
}

// MARK: - Static Styles
extension StyleBuilder {
    
    static func initialize() {
        let style = Style
        style.setupNavigationBar()
        style.setupTabBar()
        style.setupTabBarItem()
        style.setupBarButtonItem()
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
        appearance.shadowImage = UIImage()
    }
    
    private func setupTabBarItem() {
        let appearance = UITabBarItem.appearance()
        appearance.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 14)], for: .normal)
    }
    
    private func setupBarButtonItem() {
        //let appearance = UIBarButtonItem.appearance()
        //appearance.setBackButtonTitlePositionAdjustment(UIOffset.init(horizontal: -200, vertical: 0), for: .default)
    }
    
}
