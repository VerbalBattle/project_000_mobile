//
//  LoginViewController.swift
//  ButterUp
//
//  Created by Horst Schmalfuß on 30.10.15.
//  Copyright © 2015 ButterUp inc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var auth = Auth()
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!
    
    @IBAction func toSignUp(sender: UIButton) {
        performSegueWithIdentifier("signUp", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Title for TabBarItem"; // TabBarItem.title inherits the viewController's self.title
        self.navigationItem.title = "Login with Email";
        let b = UIBarButtonItem(title: "Sign Up", style: .Plain, target: self, action: "toSignUp:")
        
        self.navigationItem.rightBarButtonItem = b;
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addToken(authenticated: Bool, token: String) {
        print(authenticated)
        if (authenticated) {
            print("signed in")
            
            let defaults = NSUserDefaults.standardUserDefaults()
            
            defaults.setValue(token, forKey: "token")
            defaults.synchronize()
            
            // perform segue
            
            func validateLoginSegue() {
                performSegueWithIdentifier("tokenValidationLogin", sender: nil)
            }

            UserRequests().getUser(validateLoginSegue)
            

        } else {
            print("user not signed in")
            // display that the signup up was unsuccessfull -> username already in use
        }
    }

    @IBAction func loginUser(sender: AnyObject) {
        print("login user")
        let user = username.text
        let pass = password.text
        auth.signin(user!, password: pass!, callback: addToken)
//        callback if return user valid only the segue
    }
   

}
