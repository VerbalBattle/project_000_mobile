//
//  Auth.swift
//  
//
//  Created by Horst Schmalfuß on 29.10.15.
//
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class Auth {
    func getToken() -> String {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let name = defaults.stringForKey("token")
        {
            return name
        }
        return ""
    }
    
    func signin(username:String, password: String, callback: (Bool, String) -> Void) {
//        same here
//        printout user credentials
        
        let parameters = [
            "username": username,
            "password": password
        ]
        
        print("getting login")
        
        Alamofire.request(.POST, "http://localhost:3000/auth/login", parameters: parameters, encoding: .JSON).responseJSON { response in
            if let status = response.result.value {
                let json = JSON(status)
                let token = json["token"]
                if token != nil {
                    callback(true, token.stringValue)
                } else {
                    callback(false, "")
                }
            }
        }
    }
    
    func signUp(username:String, password: String, callback: (Bool, String) -> Void) {
//        make signin post request and write data to local storage
        let parameters = [
            "username": username,
            "password": password
        ]
        Alamofire.request(.POST, "http://localhost:3000/auth/signup", parameters: parameters, encoding: .JSON).responseJSON { response in
            if let status = response.result.value {
                let json = JSON(status)
                let token = json["token"]
                if token != nil {
                    callback(true, token.stringValue)
                } else {
                    callback(false, "")
                }
            }
        }
    }
    
    func signOut() {
//        delete current user cookie out of local storage
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.removeObjectForKey("token")
        defaults.removeObjectForKey("user")

        defaults.synchronize()
    }
}