//
//  Match.swift
//  ButterUp
//
//  Created by Horst Schmalfuß on 02.11.15.
//  Copyright © 2015 ButterUp inc. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class Match {
    
    func makeMath(ID: Int, stats: AnyObject) {
        
        var params = [
            "avatarID":ID,
            "playerstats":stats
        ]
        
        Alamofire.request(.POST, "http://localhost:3000/matchmaking", parameters: params)
    }
    
}
