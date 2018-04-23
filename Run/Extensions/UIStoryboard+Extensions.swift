//
//  UIStoryboard+Extensions.swift
//  Run
//
//  Created by Douglas Taquary on 21/04/18.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    class func main() -> UIStoryboard {
        return UIStoryboard(name: StoryboardName.main.rawValue, bundle: nil)
    }
    
    func viewController(withID identifier:ViewControllerStoryboardIdentifier) -> UIViewController {
        return self.instantiateViewController(withIdentifier: identifier.rawValue)
    }
}

