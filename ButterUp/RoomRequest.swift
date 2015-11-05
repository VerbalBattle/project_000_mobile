//
//  RoomRequest.swift
//  ButterUp
//
//  Created by Horst Schmalfuß on 05.11.15.
//  Copyright © 2015 ButterUp inc. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RoomRequest {
    
    var token = Auth().getToken()
    var url = "http://localhost:3000"

    
    func postMessage(roomID: String, message: String, avID:String) {
        
        print("posting to messages", message)
        let URL =  url + "/rooms/" + roomID
        let headers = ["Authorization": "bearer \(token)"]
        
        
        //     "avatarID": 23,
        //     "message": "my message is here"
        
        var params = [
            "message": message,
            "avatarID": avID
        ]
        
        Alamofire.request(.POST, URL, headers: headers,parameters: params, encoding: .JSON)
        
    }
    
    func getMessages(roomID: String, callback:([String:JSON])->Void) {
        
        let URL =  url + "/rooms/" + roomID
        let headers = ["Authorization": "bearer \(token)"]
        
        Alamofire.request(.GET, URL, headers: headers, encoding: .JSON)
            .responseJSON { response in
                if let messages = response.result.value {
                    print(response)
                    let json = JSON(messages)
                    var messages = json["rooms"][roomID]["messages"]
                    var messageDict:[String:JSON] = [:]
                    for (key,oneMessage):(String, JSON) in messages {
                        messageDict[key] = oneMessage
                    }
                    callback(messageDict)
                }

        }
        
    }
    
    
}