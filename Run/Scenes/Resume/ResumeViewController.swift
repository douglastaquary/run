//
//  ResumeViewController.swift
//  Run
//
//  Created by Douglas Taquary on 15/04/18.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import UIKit

public class ResumeViewController: UIViewController {
    
    public var delegate: PermissionRequestViewControllerDelegate?
    
    var theView: PermissionRequestView {
        // I don't like this `!` but it's a framework limitation
        return self.view as! PermissionRequestView
    }
    
    override public func loadView() {
        let view = PermissionRequestView()
        self.view = view
    }
    
    override public func viewDidLoad() {
//        let viewModel = PermissionRequestViewModel { [weak self] in
//            self?.didFinish()
//        }
        
        //theView.viewModel = viewModel
    }

    func didFinish(){
        //self.delegate?.didFinish(on: self)
    }
    
}
