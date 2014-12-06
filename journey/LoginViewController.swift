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
    
    @IBOutlet weak var goToSignIn: UIButton!
    @IBOutlet weak var goToSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        if ((!self.isBeingPresented()) && LoginHelper.preventDismiss.boolValue == false) {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func signIn(sender: UIButton) {
        infoLabel.hidden = true
        
        if (signInEmailField.hasText() && signInPassField.hasText()) {
            Authentication().login("nekdo")
            self.dismissViewControllerAnimated(false, completion: nil)
            
        } else {
            infoLabel.hidden = false
            infoLabel.text = "Please enter email and password"
        }
    }
    
    @IBAction func signUp(sender: UIButton) {
        Authentication().login("nekdo")
        LoginHelper.preventDismiss = false
        self.dismissViewControllerAnimated(false, completion: nil)
        
    }
    
    
    @IBAction func goToSignUp(sender: UIButton) {
        self.performSegueWithIdentifier("goToSignUp", sender: self)
    }
    
    @IBAction func goToSignIn(sender: UIButton) {
        LoginHelper.preventDismiss = true
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

struct LoginHelper {
    static var preventDismiss: Bool = true
}
