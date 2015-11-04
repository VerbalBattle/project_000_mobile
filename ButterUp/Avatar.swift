//
//  Avatar.swift
//  
//
//  Created by Horst Schmalfuß on 29.10.15.
//
//

import Foundation
import Alamofire


class Avatar {
    
    var avatarID: Int
    var avatarData: AnyObject
    var avatarStats: AnyObject?
    var userid: Int
    
    init (avatarID: Int, avatarData: AnyObject, userid: Int) {
        self.avatarID = avatarID
        self.avatarData = avatarData
        self.userid = userid
    }
    
    func edit (avatarData: AnyObject) {
        self.avatarData = avatarData
//        post request to user with userID
        
        
    }
    
    func add () {
//  make post request to /avatars ->transform into json
//        class that does that
        
    }
    

}

