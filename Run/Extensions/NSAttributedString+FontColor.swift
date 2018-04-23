//
//  NSAttributedString+FontColor.swift
//  Run
//
//  Created by Douglas Taquary on 09/04/2018.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    convenience init(string: String, font: UIFont?, color: UIColor?) {
        var attributes = [NSAttributedStringKey: Any]()
        
        if let font = font {
            attributes[.font] = font
        }
        
        if let color = color {
            attributes[.foregroundColor] = color
        }
        
        self.init(string: string, attributes: attributes)
    }
    
    func highlight(string highlightString: String,
                   font: UIFont?,
                   color: UIColor?) -> NSAttributedString {
        guard highlightString.count != 0 else {
            return self
        }
        
        let string = self.string as NSString
        let range = string.range(of: highlightString)
        
        guard range.location != NSNotFound else {
            return self
        }
        
        let attributedString = NSMutableAttributedString(attributedString: self)
        
        if let font = font {
            attributedString.addAttribute(.font,
                                          value: font,
                                          range: range)
        }
        
        if let color = color {
            attributedString.addAttribute(.foregroundColor,
                                          value: color,
                                          range: range)
        }
        
        return NSAttributedString(attributedString: attributedString)
    }
    
}

