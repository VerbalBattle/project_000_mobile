//
//  User.swift
//  
//
//  Created by Horst Schmalfuß on 29.10.15.
//
//

import Foundation

class User {
    
    var id: Int
    var avatars: [Int: AnyObject]

    init (id: Int, avatars: [Int: AnyObject]) {
        self.id = id
        self.avatars = avatars
    }

    func addAvatar(id: Int, avatar: AnyObject) {
//      setting new avatar to dictionary
        self.avatars[id] = avatar
    }

    func deleteAvatar(id: Int) {
        self.avatars[id] = nil
    }

    func signUp() {
      
        
    }
    
    func signIn() {
//        post request to auth/signin {user as json}
    }
}