//
//  LoginViewController.swift
//  journey
//
//  Created by Zuzana Dostálová on 28/10/14.
//  Copyright (c) 2014 zuzana.dostalova. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet weak var checkEmail: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var signInEmailField: UITextField!
    @IBOutlet weak var signInPassField: UITextField!
    @IBOutlet weak var singUpEmailField: UITextField!
    
    @IBOutlet weak var goToSignIn: UIButton!
    @IBOutlet weak var goToSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        infoLabel.hidden = true
        if ((!self.isBeingPresented()) && LoginHelper.preventDismiss.boolValue == false) {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        
    }
    
    @IBAction func signIn(sender: UIButton) {
        
        let email = signInEmailField.text
        let pass = signInPassField.text
        var userToken:String?
    
        // Signing in at the server - for testing use test@journeyapp.net / mobileapp
        Alamofire.request(.POST, "http://journeyapp.net/api/v1/tokens", parameters: ["email": email, "password": pass])
            .responseJSON { (_, _, response, _) in
                let hash = response! as Dictionary<String, String>;
                
                if (hash["authentication_token"] != nil) {
                    userToken = hash["authentication_token"]
                    Authentication().login(userToken!)
                    self.dismissViewControllerAnimated(false, completion: nil)

                } else {
                   self.infoLabel.text = "Authentication failed"
                    self.infoLabel.hidden = false
                }
        }
        
   
    }
    
    // TODO Server signup!
    @IBAction func signUp(sender: UIButton) {
        self.checkEmail.alpha = 1
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
