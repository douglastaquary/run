//
//  Appereance.swift
//  Run
//
//  Created by Douglas Taquary on 09/04/2018.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import Foundation
import UIKit

struct Apperance{
    
    static func customizeNavigationBar() {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = .black
        navigationBarAppearace.layer.opacity = 0.75
        navigationBarAppearace.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.green ]
    }
    
}

