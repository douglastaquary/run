//
//  ActivityViewItem.swift
//  Run
//
//  Created by Douglas Taquary on 09/04/2018.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import UIKit

final class ActivityViewItem: BaseViewTemplate {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var largeValueLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    static func height() -> CGFloat {
        return 260
    }

}
