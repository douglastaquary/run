//
//  ActivityViewController.swift
//  Run
//
//  Created by Douglas Taquary on 08/04/2018.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {

    var theView: ActivityView {
        // I don't like this `!` but it's a framework limitation
        return self.view as! ActivityView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        // To avoid warnings of autolayout while the view
        // is not resized by the system
        let frame = UIScreen.main.bounds
        let view = ActivityView(frame: frame)
        self.view = view
    }
}

