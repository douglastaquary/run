//
//  SignInViewController.swift
//  Run
//
//  Created by Douglas Taquary on 08/04/2018.
//  Copyright © 2018 Douglas Taquary. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var nameErrorMessageLabel: UILabel!
    @IBOutlet weak var ageErrorMessageLabel: UILabel!
}

extension SignInViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
