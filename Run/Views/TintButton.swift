//
//  TintButton.swift
//  Run
//
//  Created by Douglas Taquary on 09/04/2018.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import UIKit

public class TintButton: UIButton {
    
    static let lightGray = UIColor(red: 241/255, green: 243/255, blue: 246/255, alpha: 1)
    
    override public required init(frame: CGRect) {

        self.title = ""
        
        super.init(frame: frame)
        
        setBackgroundImage(UIImage.image(with: .red),
                           for: .normal)
        layer.cornerRadius = 8 / 2
        layer.masksToBounds = true
        let padding: CGFloat = 8 * 2
        contentEdgeInsets = UIEdgeInsetsMake(padding, padding, padding, padding)
    }
    
    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    public var title: String {
        didSet {
            let attributedString = NSAttributedString(string: title,
                                                      font: UIFont.systemFont(ofSize: 22, weight: .bold),
                                                      color: TintButton.lightGray)
            
            setAttributedTitle(attributedString,
                               for: .normal)
        }
    }
    
}
