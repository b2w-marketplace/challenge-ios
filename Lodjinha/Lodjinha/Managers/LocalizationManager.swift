//
//  LocalizationManager.swift
//  Lodjinha
//
//  Created by Marcos on 18/04/19.
//  Copyright © 2019 Alessandro. All rights reserved.
//

import Foundation

class LocalizationManager {
    
    fileprivate struct Constants {
        static let defaultLanguage = "pt"
        static let baseBundle = "Portuguese"
    }
    
    static var language: String? {
        get {
            return Constants.defaultLanguage
        } set {
            guard let _ = newValue else {
                return
            }
        }
    }
    
    static var phoneDeviceLanguage: String? {
        return Locale.current.languageCode
    }
    
    private static var availableLanguage: [String] {
        var availableLanguages = Bundle.main.localizations
        
        if let indexOfBase = availableLanguages.index(of: Constants.baseBundle) {
            availableLanguages[indexOfBase] = Constants.defaultLanguage
        }
        return availableLanguages
    }
    
    static func localized(_ str: String, with language: String? = nil) -> String {
        let bundle: Bundle = .main
        let lang: String
        if let language = language {
            lang = language
        } else {
            lang = LocalizationManager.language ?? Constants.defaultLanguage
        }
        
        if let path = bundle.path(forResource: lang, ofType: "lproj"),
            let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: str, value: nil, table: nil)
        } else if let path = bundle.path(forResource: Constants.baseBundle, ofType: "lproj"),
            let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: str, value: nil, table: nil)
        }
        
        return str
    }
}
