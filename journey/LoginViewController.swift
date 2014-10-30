//
//  LoginViewController.swift
//  journey
//
//  Created by Zuzana Dostálová on 28/10/14.
//  Copyright (c) 2014 zuzana.dostalova. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signIn(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true);
    }

    @IBAction func signUp(sender: UIButton) {
        navigationController?.popToRootViewControllerAnimated(true)    }
}
