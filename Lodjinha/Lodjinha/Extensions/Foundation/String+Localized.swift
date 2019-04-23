//
//  String+Localized.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return LocalizationManager.localized(self)
    }
    
    func localized(lang: String) -> String {
        return LocalizationManager.localized(self, with: lang)
    }
}
