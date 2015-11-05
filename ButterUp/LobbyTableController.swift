//
//  LobbyTableController.swift
//  ButterUp
//
//  Created by Horst Schmalfuß on 01.11.15.
//  Copyright © 2015 ButterUp inc. All rights reserved.
//

import UIKit
import SwiftyJSON

class LobbyTableController: UITableViewController {
    
    @IBOutlet weak var avatars: UITableView!
    
    var myArray = ["simon","bowen", "zack", "blaine"]
    var avatar: [String:JSON] = [:]
    var avatarID: [String] = []
    var avatarHandler = AvatarRequests()
    var buser = User()

    var request = AvatarRequests()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = buser.getUser()
       
        for (key,value) in user["avatars"] {
            avatar[key] = value
        }
        avatarID = [String] (avatar.keys)

        
    }
    
    
    // UITableViewDataSource Functions
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.avatar.count
    }
    
    func matchmaking(sender: AnyObject) {
        print(sender)
        let button = sender as! UIButton
        let view = button.superview  as! UITableViewCell
        
        var user = buser.getUser()
        
        if let cellIndexPath = self.tableView.indexPathForCell(view) {
            let indx = cellIndexPath.row
            let curravatarID = avatarID[indx]
          
            if let item = avatar[curravatarID] {
//                print(item["stats"])
//                elo: avatarStats['Elo'],
//                avatarType: avatarStats['Avatar Type'],
//                winLossRatio: avatarStats['Win/Loss Ratio'],
//                winStreak: avatarStats['Win Streak']
//            };
                var elo = item["stats"]["elo"].intValue
                var type = item["stats"]["avatarType"].string
                var winLossRatio = item["stats"]["winLossRatio"].intValue
                var winStr = item["stats"]["winStreak"].int
               
                avatarHandler.matchMaking(Int(curravatarID)! , elo: elo, type: type!, winloss: winLossRatio, winStreak: winStr!)
            }
            
        }
        
    }
    
    func goRoom (sender: UIButton) {
        print("going to room")
        let tabViewController = self.storyboard!.instantiateViewControllerWithIdentifier("realRoom") as! RoomViewController
        
        let button = sender as!
        UIButton
        
        let view = button.superview  as! UITableViewCell
        
        if let cellIndexPath = self.tableView.indexPathForCell(view) {
            //     slice array at index cellIndexPath.row
            let indx = cellIndexPath.row
            let curravatarID = avatarID[indx]
            tabViewController.id = Int(curravatarID)!
//            tabViewController.roomID = Int()
            
//            getting roomID
            var user = User()
            var u = user.getUser()
////            getting the number of which room is actually getting chose
//            tabViewController.roomID = u["avatars"][curravatarID]["rooms"]["1"]["roomID"].string!
//            print(u["avatars"][curravatarID]["rooms"]["1"]["roomID"], "this is what i want to print") -> getting roomID to pass to roomviewcontroller
//           
           
        }
        self.presentViewController(tabViewController, animated: true, completion: nil)
        
    
}

       

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        let cell = UITableViewCell()
        let avatarName = UILabel(frame: CGRect(x:20, y:20, width:200, height:60))
        let aboutMe = UILabel(frame: CGRect(x:20, y:20, width:200, height:120))
        let button = UIButton(frame: CGRect(x:180, y:40, width:140, height:60))
        button.addTarget(self, action: "matchmaking:", forControlEvents: .TouchUpInside)
        
        button.setTitle("Make Match", forState: UIControlState.Normal)
        button.backgroundColor = UIColor.greenColor()
        cell.addSubview(button)
        var label = UILabel(frame: CGRect(x:280, y:40, width:140, height:60))
        var joinRoom = UIButton(frame: CGRect(x:140, y:40, width:140, height:60))
        joinRoom.backgroundColor = UIColor.blueColor()
        joinRoom.addTarget(self, action: "goRoom:", forControlEvents: .TouchUpInside)
        
        if let lab = self.avatar[avatarID[indexPath.row]] {
            avatarName.text = lab["avatarName"].string
            aboutMe.text = lab["aboutMe"].string
            var rooms = lab["rooms"]
            
            for (key,subJson):(String, JSON) in rooms {
//                print(subJson)
                var opponent = subJson["opponentName"]
                joinRoom.setTitle(subJson["roomID"].string, forState: UIControlState.Normal)
                label.text = opponent.string
//             atach value to button to see which id got picked -> send roomID to cha view
//                and make get/post to rooms/:roomID to get all the messages
                print(subJson["roomID"])
            }
            
            
            
            print("rooms", rooms)
            cell.addSubview(joinRoom)
            cell.addSubview(label)
            cell.addSubview(aboutMe)
            cell.addSubview(avatarName)
            
            
      }
        return cell
    }
    
    
    // UITableViewDelegate Functions
        override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return 150
        }
    
    
    func handleClick(sender: UIButton) {
        print("got clicked, making match")
//        making post request to matchmaking
        
    }

 
}