//
//  TabBarImageViewFactory.swift
//  desafiob2w
//
//  Created by Lázaro Lima dos Santos on 19/06/18.
//  Copyright © 2018 B2w. All rights reserved.
//

import UIKit

enum TabBarImageViewFactory {
    static func make() -> UIImageView {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        image.image = R.image.logoApp()
        image.contentMode = .scaleAspectFit
        return image
    }
}
