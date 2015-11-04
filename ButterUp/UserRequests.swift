//
//  UserRequests.swift
//  
//
//  Created by Horst Schmalfuß on 02.11.15.
//
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class UserRequests {
    var token = Auth().getToken()
    var url = "http://localhost:3000"
    
    func getUser(callback: () -> Void) {
        let URL =  url + "/users"
        let headers = ["Authorization": "bearer \(token)"]
        
        Alamofire.request(.GET, URL, headers: headers)
            .responseJSON { response in
            if let user = response.result.value {
                let json = JSON(user)
                
                let str = json.rawString(NSUTF8StringEncoding)
                
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setValue(str, forKey: "user")
                defaults.synchronize()
                
                callback()
            }
        }
    }
}
