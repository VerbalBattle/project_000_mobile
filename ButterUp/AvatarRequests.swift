//
//  RequestFile.swift
//  ButterUp
//
//  Created by Horst Schmalfuß on 02.11.15.
//  Copyright © 2015 ButterUp inc. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class AvatarRequests {
    var token = Auth().getToken()
    let url = "http://localhost:3000"
    
    func postAvatar(data: String, avatarName:String, avatarAboutMe:String, callback:([String:JSON])->Void) {
//    func postAvatar(data:String, avatarName:String, avatarAboutMe:String) {

        let URL =  url + "/avatars"
        let headers = ["Authorization": "bearer \(token)"]

        let parameters = [
            "avatarData": [
                "avatarName": avatarName,
                "imageSource": data,
                "aboutMe": avatarAboutMe
            ]
        ]
        print("getting called here")
//        add header injection
//        compress image
//
        Alamofire.request(.POST, URL, parameters: parameters, headers: headers, encoding: .JSON).responseJSON { response in
            if let user = response.result.value {
                let json = JSON(user)
                for (key, avatar):(String, JSON) in json["avatars"] {
                    callback([key:avatar])
                }
            }
        }
    }
    
    func deleteAvatar(avatarID: String) {
        let URL =  url + "/avatars/" + avatarID
        let headers = ["Authorization": "bearer \(token)"]
        
        Alamofire.request(.DELETE, URL, headers: headers, encoding: .JSON)
    }
    
    func editAvatar() {
        
    }
    
    func getAvatars(userID: Int) {
//        reuqest to profile/login to get avatars back?
//        Alamofire.request(.GET, "http://localhost:3000/avatars")
    }
    
    
    func putAvatar(avatarID: String, data: String, avatarName:String, AboutMe: String) {
        
        let parameters = [
            "avatarData": [
                "imageSource": data,
                "aboutMe": AboutMe
            ]
        ]

        let URL =  url + "/avatars/" + avatarID
        let headers = ["Authorization": "bearer \(token)"]
        
        Alamofire.request(.PUT, URL, parameters: parameters, headers: headers, encoding: .JSON)


    }
    
 }


