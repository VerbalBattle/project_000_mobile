//
//  SignupViewController.swift
//  ButterUp
//
//  Created by Horst Schmalfuß on 02.11.15.
//  Copyright © 2015 ButterUp inc. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    var auth = Auth()
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signUp: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Title for TabBarItem"; // TabBarItem.title inherits the viewController's self.title
        self.navigationItem.title = "Sign Up";
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addToken(authenticated: Bool, token: String) {
        print(authenticated)
        if (authenticated) {
            print("signed up" + token)
            
            let defaults = NSUserDefaults.standardUserDefaults()
            
            defaults.setValue(token, forKey: "token")
            defaults.synchronize()
            performSegueWithIdentifier("tokenValidationSignUp", sender: nil)

            // perform segue
          
        } else {
            print("user not signed up")
            // display that the signup up was unsuccessfull -> username already in use
        }
    }

    @IBAction func signUp(sender: AnyObject) {
        print("Signup user")
        let user = username.text
        let pass = password.text
        auth.signUp(user!, password: pass!, callback:
            addToken)
 
        // callback if return user valid only the segue
    }
}
