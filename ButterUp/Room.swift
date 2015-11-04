//
//  Room.swift
//  
//
//  Created by Horst Schmalfuß on 29.10.15.
//
//

import Foundation


class Room {
    
    var id: Int
    var users: [Int]
    var messages = [Int: String]()
    
    init (id: Int, users: [Int], messages:[Int: String]) {
        self.id = id
        self.users = users
    }
    
//    func setMessage (message:String, sender: Int) {
////        add message to message dictionary
//        
//        var message = Message(text: message, sender: sender, roomID: self.id)
//        //save message
//    
//        
//        
//    }
}