//
//  VoteRequest.swift
//  ButterUp
//
//  Created by Horst Schmalfuß on 05.11.15.
//  Copyright © 2015 ButterUp inc. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class VoteRequest {
    
    var token = Auth().getToken()
    let url = "http://localhost:3000"

    func getClosedRoom () {
        
        let URL =  url + "/judging"
        print("making get to judging")
        let header = ["Authorization": "bearer \(token)"]
        print("if last thing here then no closed rooms")
        Alamofire.request(.GET, URL, headers:header).responseJSON { response in
            print(response)
            if let closedRooms = response.result.value {
                print("closed rooms:", closedRooms)
            }
        }
    }
    
    func upvoteAvatar(id: String, roomID: String) {
        let URL =  url + "/judging/" + roomID
     
        let header = ["Authorization": "bearer \(token)"]
        
        let params = [
            "upvoteID":id
        ]
        
        Alamofire.request(.PUT, URL, headers:header, parameters:params)

    }
}

