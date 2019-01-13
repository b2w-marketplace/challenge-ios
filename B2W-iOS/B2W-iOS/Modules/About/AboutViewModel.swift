//
//  AboutViewModel.swift
//  B2W-iOS
//
//  Created by Renato Machado Filho on 11/01/19.
//  Copyright © 2019 Renato Machado Filho. All rights reserved.
//

import UIKit

protocol AboutViewModelInterface: ViewModelInterface {
    func getNavigationTitle() -> String?
    func getDeveloperImageUrl() -> String
}

class AboutViewModel: AboutViewModelInterface {
    
    required init() {}
    
    func getNavigationTitle() -> String? {
        return "Sobre"
    }
    
    func getDeveloperImageUrl() -> String {
        return "https://avatars1.githubusercontent.com/u/8006893?s=460&v=4"
    }
}
