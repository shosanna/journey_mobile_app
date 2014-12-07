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
        
        let email = signInEmailField.text
        let pass = signInPassField.text
        var userToken:String?
    
        
        Alamofire.request(.POST, "http://localhost:3000/api/v1/tokens", parameters: ["email": email, "password": pass])
            .responseJSON { (_, _, token, _) in
                userToken = (token! as NSDictionary)["authentication_token"] as NSString
                println(userToken)
                if (userToken != nil) {
                    Authentication().login(userToken!)
                    self.dismissViewControllerAnimated(false, completion: nil)

                } else {
                    self.infoLabel.hidden = false
                    self.infoLabel.text = "Authentication failed"
                }
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
