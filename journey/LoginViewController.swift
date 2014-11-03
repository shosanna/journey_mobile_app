//
//  LoginViewController.swift
//  journey
//
//  Created by Zuzana Dostálová on 28/10/14.
//  Copyright (c) 2014 zuzana.dostalova. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var signInEmailField: UITextField!
    @IBOutlet weak var signInPassField: UITextField!
    @IBOutlet weak var singUpEmailField: UITextField!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signIn(sender: UIButton) {
        infoLabel.hidden = true
        
        if (signInEmailField.hasText() && signInPassField.hasText()) {
            Authentication().login("nekdo")
            navigationController!.popViewControllerAnimated(true);
        } else {
            infoLabel.hidden = false
            infoLabel.text = "Please enter email and password"
        }
    }

    @IBAction func signUp(sender: UIButton) {
        navigationController!.popToRootViewControllerAnimated(true)
    }
}
