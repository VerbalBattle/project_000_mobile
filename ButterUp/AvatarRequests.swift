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

class AvatarRequests {
    var token = Auth().getToken()
    let url = "http://localhost:3000"
    
    func postAvatar(data: String, avatarName:String, avatarAboutMe: String) {
//        post request to server to send avatar data
//        post with alamofire
//        Expected request body example
        // {
        //     "avatarData": {
        //         "avatarName": "joey's avatar",
        //         "image": binary_stuff_here,
        //         "aboutMe": "I'm joey and I play to win."
        //     }
        // }
        
        // Decrypt token
        
//        todo: include headers for auth
        
        let URL =  url + "/avatars"
        let headers = ["Authorization": "bearer \(token)"]

        let parameters = [
            "avatarData": [
                "avatarName": avatarName,
                "imageSource": "data:image/png;base64," + data,
                "aboutMe": avatarAboutMe
            ]
        ]
        print("getting called here")
//        add header injection
//        compress image
//
        Alamofire.request(.POST, URL, parameters: parameters, headers: headers, encoding: .JSON).responseJSON { response in
            print(response)
        }
    }
    
    func deleteAvatar(avatarID: Int) {
        
        
        
    }
    
    func editAvatar() {
        
    }
    
    func getAvatars(userID: Int) {
//        reuqest to profile/login to get avatars back?
//        Alamofire.request(.GET, "http://localhost:3000/avatars")
    }
}
